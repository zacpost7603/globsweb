require "test_helper"

class GlobTest < ActiveSupport::TestCase
  test "has a valid factory" do 
    glob = FactoryBot.build :glob
    
    assert glob.valid?
  end
  test "requires a user" do 
    glob = FactoryBot.build :glob
    glob.user = nil
    
    refute glob.valid?
  end
  test "requires a title" do 
    glob = FactoryBot.build :glob
    glob.title = ""
    
    refute glob.valid?
  end
end
