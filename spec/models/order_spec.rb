require "rails_helper"

RSpec.describe Order, type: :model do
  describe "associations" do
    it "belongs to user" do
      is_expected.to belong_to(:user)
    end
    it "has many order_details" do
      is_expected.to have_many(:order_details).dependent :destroy
    end
  end

  describe "validations" do
    it {should validate_presence_of(:quantity) }
    it {should validate_numericality_of(:quantity).only_integer }
  end
end
