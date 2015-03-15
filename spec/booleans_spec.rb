require 'rspec/given'
require_relative '../booleans'

describe "booleans" do
  describe "IF" do
    Then { IF[TRUE]['happy']['sad'] == 'happy' }
    Then { IF[FALSE]['happy']['sad'] == 'sad' }
  end

  describe "to_boolean" do
    Then { to_boolean(TRUE) == true }
    Then { to_boolean(FALSE) == false }
  end
end