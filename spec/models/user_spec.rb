require "rails_helper"

RSpec.describe User, type: :model do
  let(:user){FactoryBot.create :user}

  it "has a valid user" do
    expect(build(:user)).to be_valid
  end

  describe "validations" do
    describe "name" do
    it {is_expected.to validate_presence_of(:name).with_message(
      I18n.t("activerecord.errors.models.user.attributes.name.blank"))}
    end

    describe "email" do
    it {is_expected.to validate_presence_of(:email).with_message(
      I18n.t("activerecord.errors.models.user.attributes.name.blank"))}
    end

    describe "password" do
      it { is_expected.to validate_presence_of(:password) }
      it "when password is too short" do
        user.password = Faker::Number.number 5
        user.valid?
        expect(user.errors.messages[:password].first).to eq(
          I18n.t "activerecord.errors.models.user.attributes.password.too_short",
          count: Settings.user.min_password)
      end

      it "when password is too long" do
        user.password = Faker::Number.number 16
        user.valid?
        expect(user.errors.messages[:password].first).to eq(
          I18n.t "activerecord.errors.models.user.attributes.password.too_long",
          count: Settings.user.max_password)
      end
    end
  end

  describe "associations" do
    it "have many comments" do
      is_expected.to have_many(:comments).dependent :destroy
    end

    it "have many suggests" do
      is_expected.to have_many(:suggests).dependent :destroy
    end

    it "have many likes" do
      is_expected.to have_many(:likes).dependent :destroy
    end

    it "have many reviews" do
      is_expected.to have_many(:reviews).dependent :destroy
    end

    context "presence" do
      it { should validate_presence_of :name }
    end
  end

  describe "roles" do
    it "are user or admin" do
      is_expected.to define_enum_for(:role).with_values %i(user admin)
    end
  end
end
