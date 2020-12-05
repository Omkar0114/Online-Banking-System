require 'test_helper'

class AdminLogoutTest < ActionDispatch::IntegrationTest
  test "logout with valid credenttials" do
    get admin_login_url
    assert_response :success
    assert_not is_admin_logged_in?
    assert_template 'admin_sessions/new'
    post admin_login_url, params: { session: {email: "admin@gmail.com", password: '12345678'}}
    assert_redirected_to admin_users_path
    follow_redirect!
    assert_template 'admin_users/index'
    assert is_admin_logged_in?
    delete admin_logout_path
    assert_redirected_to admin_login_path
    assert_not is_admin_logged_in?

  end
end
