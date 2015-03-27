require 'rspec/given'
require_relative '../derivative'

describe "derivative functions" do
  Then { two == 2 }
  Then { three == 3 }
  Then { add_three(two) == 5}
end