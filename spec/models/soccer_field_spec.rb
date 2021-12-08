require "rails_helper"

RSpec.describe SoccerField, type: :model do
  describe "associations" do
    it {should have_many(:order_details)}
    it {should have_many(:comments)}
  end

  describe "validations" do
    it { should validate_presence_of(:field_name) }
    it { should validate_length_of(:field_name).is_at_most(Settings.rspec.model.name_length_max_50) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:description).is_at_most(Settings.rspec.model.length_max_255) }
    it { should validate_numericality_of(:price).only_integer }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(100_00) }
    it { should validate_numericality_of(:price).is_less_than_or_equal_to(100_000) }
    it { should define_enum_for(:status).with_values([:left, :over]) }
    it { should define_enum_for(:type_field).with_values([:five, :seven, :elevent]) }
  end

  describe "scope search SoccerField" do
    it "search with no input" do
      expect(SoccerField.search_name("")).to be_truthy
    end
    it "search with valid input" do
      expect(SoccerField.search_name("H")).to be_truthy
    end
    it "search with invalid input" do
      expect(SoccerField.search_name("***")).to match_array([])
    end
  end
end
