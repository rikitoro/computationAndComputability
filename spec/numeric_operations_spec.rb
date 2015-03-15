require 'rspec/given'
require_relative '../numeric_operations'
require_relative '../numbers'

describe "numeric_operations" do
  describe "INCREMENT" do
    Then { to_integer(INCREMENT[ZERO]) == 1 }
    Then { to_integer(INCREMENT[ONE]) == 2 }
    Then { to_integer(INCREMENT[FIFTEEN]) == 16 }
  end
end