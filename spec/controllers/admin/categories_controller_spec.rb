require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  describe "when current user is not admin" do
    before {get :index}

     it "flash success message" do
      expect(flash[:danger]).to match(I18n.t "no_admin")
    end

     it "redirect to home page" do
      expect(response).to redirect_to root_path
    end
  end

  describe "when current user is admin" do
    login_admin
    before {get :index}

     it "should have a current_user" do
      expect(subject.current_user).to_not eq nil
    end
    context "POST categories#create" do
      let(:category){FactoryBot.attributes_for :category}
      let(:invalid_category){FactoryBot.attributes_for :invalid_category}

      context "valid attributes" do
        it "create new category" do
          expect{post :create, params: {category: category}}
          .to change(Category, :count).by 1
        end

        it "flash success message" do
          post :create, params: {category: category}
          expect(flash[:success]).to match(I18n.t "controller.category.create_category")
        end

        it "redirect to admin_categorys_path" do
          post :create, params: {category: category}
          expect(response).to redirect_to admin_categories_path
        end
      end
      context "invalid attributes" do
        it "does not create new category" do
          expect{post :create, params: {category: invalid_category}}
          .to_not change(Category, :count)
        end
      end
    end
  end
end
