require "spec_helper"
require "rails_helper"

RSpec.describe "users/edit.html.erb", type: :view do
  let(:user) {FactoryBot.build :user}
  subject {rendered}

  before do
    assign :user, user
    render
  end

  it {is_expected.to have_content I18n.t("users.edit.h1")}

  describe "form" do
    it {assert_select "form[action*=?]",users_path}

    it {is_expected.to have_field "user_name"}

    it {is_expected.to have_field "user_phone"}

    it {is_expected.to have_field "user_email"}

    it {is_expected.to have_field "user_country"}

    it {is_expected.to have_field "user_address"}

    it {is_expected.to have_field "user_password"}

    it {is_expected.to have_field "user_password_confirmation"}
  end
end
