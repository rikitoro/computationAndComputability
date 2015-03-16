require 'rspec/given'
require_relative '../numeric_operations'
require_relative '../booleans'

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

  describe "ADD" do
    Then { to_integer(ADD[ZERO][ZERO]) == 0 }
    Then { to_integer(ADD[ONE][ZERO]) == 1 }
    Then { to_integer(ADD[THREE][FIVE]) == 8 }
    Then { to_integer(ADD[HUNDRED][ONE]) == 101 }
  end

  describe "SUBTRACT" do
    Then { to_integer(SUBTRACT[FIVE][ZERO]) == 5 }
    Then { to_integer(SUBTRACT[FIVE][THREE]) == 2 }
    Then { to_integer(SUBTRACT[FIVE][FIVE]) == 0 }
    Then { to_integer(SUBTRACT[TWO][FIVE]) == 0 }
  end

  describe "MULTIPLY" do
    Then { to_integer(MULTIPLY[TWO][ZERO]) == 0 }
    Then { to_integer(MULTIPLY[ZERO][TWO]) == 0 }
    Then { to_integer(MULTIPLY[TWO][TWO]) == 4 }
    Then { to_integer(MULTIPLY[FIVE][THREE]) == 15 }
  end

  describe "POWER" do
    Then { to_integer(POWER[TWO][ZERO]) == 1 }
    Then { to_integer(POWER[TWO][THREE]) == 8 }
  end

  describe "IS_LESS_OR_EQUAL" do
    Then { to_boolean(IS_LESS_OR_EQUAL[ONE][TWO]) == true }
    Then { to_boolean(IS_LESS_OR_EQUAL[TWO][TWO]) == true }
    Then { to_boolean(IS_LESS_OR_EQUAL[THREE][TWO]) == false}
  end

  describe "MOD" do
    Then { to_integer(MOD[THREE][TWO]) == 1 } 
    Then { to_integer(MOD[POWER[THREE][THREE]][ADD[THREE][TWO]]) == 2 }
  end
end