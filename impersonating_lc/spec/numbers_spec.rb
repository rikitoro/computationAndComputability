require 'rspec/given'
require_relative '../numbers'

describe "numbers" do
  Then { to_integer(ZERO) == 0 }
  Then { to_integer(ONE) == 1 }
  Then { to_integer(TWO) == 2 }
  Then { to_integer(THREE) == 3 }
  Then { to_integer(FIVE) == 5 }
  Then { to_integer(FIFTEEN) == 15 }
  Then { to_integer(HUNDRED) == 100 }
  
end