require 'rspec/given'
require_relative '../pairs'
require_relative '../numbers'

describe "pairs" do
  subject(:subject) { PAIR[THREE][FIVE] }
  Then { to_integer(LEFT[subject]) == 3 }
  Then { to_integer(RIGHT[subject]) == 5 }
end