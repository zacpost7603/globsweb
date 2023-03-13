require "test_helper"

class GlobsTest < ActionDispatch::IntegrationTest
  test "globs are visible to logged on users" do
    user = login_user
    glob1 = FactoryBot.create :glob, user: user
    glob2 = FactoryBot.create :glob
    
    visit globs_path
    
    assert_text "Globs"
    assert_text glob1.title
    assert_text glob2.title
    
  end
  test "globs are able to be viewed and edited by author" do
    user = login_user
    glob = FactoryBot.create :glob, user: user
    
    visit glob_path(glob.id)
   
    assert_text "View Glob"
    assert_text "Edit Glob"
    assert_text glob.author
    
    click_on "Edit Glob"
    
    assert_text "Edit Glob"
    
    fill_in "Summary", with:"test edit"
    click_button "Edit Glob"
    
    assert_text "Glob Successfully Updated"
    assert_text "test edit"
  end
  test "globs are able to be deleted by author" do
    user = login_user
    glob = FactoryBot.create :glob, user: user
    
    visit glob_path(glob.id)
    
    assert_text "View Glob"
    assert_text "Delete Glob"
    assert_text glob.author
    
    click_button "Delete Glob"
    
    assert_text "Glob was Deleted!"
    
    refute page.has_content?(glob)
    
  end
end
