require 'rspec/given'
require_relative '../fundamental'

describe "fundamental" do
  Then { zero == 0 }
  Then { increment(zero) == 1 }
  Then { increment(increment(zero)) == 2 }
end