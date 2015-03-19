require 'rspec/given'
require_relative '../lc'

describe "LCs" do
  subject(:one) { 
    LCFunction.new(:p,
      LCFunction.new(:x,
        LCCall.new(LCVariable.new(:p), LCVariable.new(:x))
      )
    ) 
  }

  subject(:increment) { 
    LCFunction.new(:n,
      LCFunction.new(:p,
        LCFunction.new(:x,
          LCCall.new(
            LCVariable.new(:p),
            LCCall.new(
              LCCall.new(LCVariable.new(:n), LCVariable.new(:p)),
              LCVariable.new(:x)
            )
          )
        )
      )
    ) 
  }
  subject(:add) { 
    LCFunction.new(:m,
      LCFunction.new(:n,
        LCCall.new(
          LCCall.new(LCVariable.new(:n), increment),
          LCVariable.new(:m)
        )
      )
    ) 
  }

  Then { one.inspect == "-> p { -> x { p[x] } }" }  
  Then { increment.inspect == 
    "-> n { -> p { -> x { p[n[p][x]] } } }" }
  Then { add.inspect ==
    "-> m { -> n { n[-> n { -> p { -> x { p[n[p][x]] } } }][m] } }" }
end

