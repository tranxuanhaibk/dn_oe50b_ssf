require "spec_helper"
require "rails_helper"

RSpec.describe "admin/soccer_fields/_form.html.erb", type: :view do
  let(:admin){FactoryBot.create(:admin)}
  let(:soccer_field) {FactoryBot.build :soccer_field}
  subject {rendered}

  before do
    assign :admin, admin
    assign :soccer_field, soccer_field
    render
  end

  describe "form" do
    it {assert_select "form[action*=?]", admin_soccer_fields_path}

    it {is_expected.to have_field "soccer_field_field_name"}

    it {is_expected.to have_selector "input", class: "btn btn-primary"}

    it {is_expected.to have_field "soccer_field_description"}

    it {is_expected.to have_field "soccer_field_price"}
  end
end
