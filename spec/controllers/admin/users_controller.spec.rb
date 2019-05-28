require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
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

    describe "GET users#index" do
      let(:user){FactoryBot.create :user}

      it "populates an array of users" do
        get :index
        expect(assigns(:users)).to include(user)
      end

      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end

    context "POST users#create" do
      let(:user){FactoryBot.attributes_for :user}
      let(:invalid_user){FactoryBot.attributes_for :invalid_user}

      context "valid attributes" do
        it "create new user" do
          expect{post :create, params: {user: user}}
          .to change(User, :count).by 1
        end

        it "flash success message" do
          post :create, params: {user: user}
          expect(flash[:success]).to match(I18n.t "controller.user.create_user")
        end

        it "redirect to admin_users_path" do
          post :create, params: {user: user}
          expect(response).to redirect_to admin_users_path
        end
      end

      context "invalid attributes" do
        before {User.create!(name: "Cuong TanPhu", email: "lqcuong.qt@gmail.com", password: "1234567899")}

        it "does not create new user" do
          expect{post :create, params: {user: invalid_user}}
          .to_not change(User, :count)
        end
      end
    end

    describe "PUT users#update" do
      let(:user){FactoryBot.attributes_for :user}
      let(:invalid_users){FactoryBot.attributes_for :invalid_users}
      before {@user = FactoryBot.create :user, name: "CuongTanPhu", email: "lqcuong.qt@gmail.com", password:"1234567899", role: "user"}

      context "valid attributes" do
        it "located the requested @user" do
          put :update, params: {id: @user, user: user}, format: :js
          expect(assigns(:user)).to eq(@user)
        end
        it "changes @user attributes" do
          put :update, params: {id: @user,
            user: FactoryBot.attributes_for(:user, role: "admin")}, format: :js
          @user.reload
          @user.role.should eq("admin")
        end
        it "redirects to admin users" do
          put :update, params: {id: @user,
            user: FactoryBot.attributes_for(:user, role: "admin")}, format: :js
          expect(response).to redirect_to request.referrer
        end
      end

      context "invalid attributes" do
        it "located the requested @user" do
          put :update, params: {id: @user, user: invalid_users}, format: :js
          expect(assigns(:user)).to eq(@user)
        end

         it "does not change @user attributes" do
          put :update, params: {id: @user, user: invalid_users}, format: :js
          @user.reload
          @user.role.should eq("admin")
        end
      end
    end

    describe "DELETE users#destroy" do
      let!(:user){FactoryBot.create :user}

       context "valid attributes" do
        it "deletes the user" do
          expect{delete :destroy, params: {id: user}}
          .to change(User, :count).by -1
        end

        it "flash success message" do
          delete :destroy, params: {id: user}
          expect(flash[:success]).to match(I18n.t "controller.user.delete_user")
        end

        it "redirect to admin_users_path" do
          delete :destroy, params: {id: user}
          expect(response).to redirect_to admin_users_path
        end
      end

      context "invalid attributes" do
        it "deletes the user" do
          expect{delete :destroy, params: {id: 23}}
          .to_not change(User, :count)
        end

        it "flash danger message" do
          delete :destroy, params: {id: 321}
          expect(flash[:danger]).to match(I18n.t "controller.user.find_user_error")
        end

        it "redirect to admin_users_path" do
          delete :destroy, params: {id: 321}
          expect(response).to redirect_to admin_root_path
        end
      end
    end
  end
end
