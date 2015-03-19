require 'rspec/given'
require_relative '../predicates'
require_relative '../numbers'
require_relative '../booleans'

describe "predicates" do
  Then { to_boolean(IS_ZERO[ZERO]) == true }
  Then { to_boolean(IS_ZERO[THREE]) == false }
  Then { to_boolean(IS_ZERO[HUNDRED]) == false }
end