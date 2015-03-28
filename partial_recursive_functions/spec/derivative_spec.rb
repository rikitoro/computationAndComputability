require 'rspec/given'
require_relative '../derivative'

describe "derivative functions" do
  Then { two == 2 }
  Then { three == 3 }
  Then { add_three(two) == 5 }
  Then { add(two, three) == 5 }
  Then { multiply(two, three) == 6 }
  Then { six == 6 }
  Then { decrement(six) == 5 }
end