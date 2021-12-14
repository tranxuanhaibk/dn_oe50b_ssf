require "rails_helper"
require "spec_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}

  subject {user}

  it "has a valid factory" do
    is_expected.to be_valid
  end

  it "is a User" do
    is_expected.to be_a_kind_of User
  end

  describe "associations" do
    it "has many orders" do
      is_expected.to have_many(:orders)
    end
    it "has many comments" do
      is_expected.to have_many(:comments).dependent :destroy
    end
    it "has many reviews" do
      is_expected.to have_many(:comments).dependent :destroy
    end
  end

  describe "is name" do
    it {should allow_value("", nil).for(:name)}
    it "is limit maximum" do
      is_expected.to validate_length_of(:name).is_at_most(
        Settings.model.profile.name_length_max_50)
    end
  end

  describe "is email" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it "is limit maximum" do
      is_expected.to validate_length_of(:email).is_at_most(
        Settings.model.user.email_max)
    end
    it "is invalid email" do
      user.email = "example"
      is_expected.not_to be_valid
    end
  end
end
