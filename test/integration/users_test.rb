require "test_helper"

class UsersTest < ActionDispatch::IntegrationTest
  test "users can sign up" do
    visit root_path
    
    click_on "Signup"
    
    fill_in "Name", with: "Test Signup"
    fill_in "Email", with: "testsignup@test.com"
    fill_in "Password", with: "secret"
    fill_in "Confirm Password", with: "secret"
    
    click_button "Sign Up"
    
    assert_equal page.current_path, root_path
    assert_text "New User"
    
    assert_text "Logout"
    refute page.has_content?("Login")
  end
  
  test "users sign up with errors" do
    visit signup_path
    
    fill_in "Name", with: "Test Signup"
    fill_in "Email", with: "testsignuptest.com" #no @ sign
    fill_in "Password", with: "secret"
    fill_in "Confirm Password", with: "secret"
    
    click_button "Sign Up"
  
    assert_text "Errors"
    
  end
end
