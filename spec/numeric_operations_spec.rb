require 'rspec/given'
require_relative '../numeric_operations'

describe "numeric_operations" do
  describe "INCREMENT" do
    Then { to_integer(INCREMENT[ZERO]) == 1 }
    Then { to_integer(INCREMENT[ONE]) == 2 }
    Then { to_integer(INCREMENT[FIFTEEN]) == 16 }
  end

  describe "DECREMENT" do
    Then { to_integer(DECREMENT[FIVE]) == 4 }
    Then { to_integer(DECREMENT[FIFTEEN]) == 14 }
    Then { to_integer(DECREMENT[HUNDRED]) == 99 }
    Then { to_integer(DECREMENT[ZERO]) == 0 }
  end
end