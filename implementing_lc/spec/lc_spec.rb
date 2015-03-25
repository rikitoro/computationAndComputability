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

describe "#replace" do
  context "replace LCVariable" do
    subject(:subject) { LCVariable.new(:x) }
    context "x [x/->y { y }]" do
      When(:replaced) { subject.replace(:x, 
        LCFunction.new(:y, LCVariable.new(:y))) }
      Then { replaced.inspect == "-> y { y }" }
    end
    context "x [z/->y { y }]" do
      When(:replaced) { subject.replace(:z, 
        LCFunction.new(:y, LCVariable.new(:y))) }
      Then { replaced.inspect == "x" } 
    end
  end

  context "replace LCCall" do
    subject(:subject) { 
      LCCall.new(
        LCCall.new(
          LCCall.new(
            LCVariable.new(:a),
            LCVariable.new(:b)
          ),
          LCVariable.new(:c)
        ),
        LCVariable.new(:b)
      ) 
    }

    context "a[b][c][b] [a/x]" do
      When(:replaced) { subject.replace(:a, LCVariable.new(:x)) }
      Then { replaced.inspect == "x[b][c][b]" }
    end

    context "a[b][c][b] [b/-> x { x }]" do
      When(:replaced) {
        subject.replace(:b,
          LCFunction.new(:x, LCVariable.new(:x)))
      }
      Then { replaced.inspect == 'a[-> x { x }][c][-> x { x }]'}
    end
  end

  context "replace LCFunction" do
    subject(:subject) { 
      LCFunction.new(:y,
        LCCall.new(LCVariable.new(:x), LCVariable.new(:y))) 
    }

    context "-> y { x[y] } [x/z]" do
      When(:replaced) { subject.replace(
        :x, LCVariable.new(:z))
      }
      Then { replaced.inspect == "-> y { z[y] }" }      
    end

    context "-> y { x[y] } [y/z]" do
      When(:replaced) { subject.replace(
        :y, LCVariable.new(:z))
      }
      Then { replaced.inspect == "-> y { x[y] }" }            
    end
  end

  context "replace complex expression x[y][-> y { y[x] }" do
    subject(:subject) { 
      LCCall.new(
        LCCall.new(LCVariable.new(:x), LCVariable.new(:y)),
        LCFunction.new(:y, 
          LCCall.new(LCVariable.new(:y), LCVariable.new(:x))
        )
      )
    }

    context "[x/z]" do
      When(:replaced) { subject.replace(:x, LCVariable.new(:z)) }      
      Then { replaced.inspect == 'z[y][-> y { y[z] }]' }
    end

    context "[y/z]" do
      When(:replaced) { subject.replace(:y, LCVariable.new(:z)) }      
      Then { replaced.inspect == 'x[z][-> y { y[x] }]' }       
     end 
  end
end

describe "LCFunction#call" do
  context "subject = -> x { -> y { x[y] } }" do
    subject(:subject) { 
      LCFunction.new(:x,
        LCFunction.new(:y,
          LCCall.new(LCVariable.new(:x), LCVariable.new(:y))
        )
      )
    }

    context "argument = -> z { z }" do
      When(:argument) { LCFunction.new(:z, LCVariable.new(:z)) }
      Then { subject.call(argument).inspect == '-> y { -> z { z }[y] }' }      
    end
  end
end

describe "#reduce" do
  Given(:one) { 
    LCFunction.new(:p,
      LCFunction.new(:x,
        LCCall.new(LCVariable.new(:p), LCVariable.new(:x))
      )
    ) 
  }
  Given(:increment) { 
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
  Given(:add) { 
    LCFunction.new(:m,
      LCFunction.new(:n,
        LCCall.new(
          LCCall.new(LCVariable.new(:n), increment),
          LCVariable.new(:m)
        )
      )
    ) 
  }
  Given(:inc) { LCVariable.new("inc") }
  Given(:zero) { LCVariable.new("zero") }

  subject(:subject) { LCCall.new(LCCall.new(add, one), one) }

  When(:reduced_expression) {
    sut = subject
    while sut.reducible?
      sut = sut.reduce
    end
    sut
  }
  When(:called_expression) {
    LCCall.new(LCCall.new(reduced_expression, inc), zero)    
  }
  When(:reduced_called_expression) {
    sut = called_expression
    while sut.reducible?
      sut = sut.reduce
    end
    sut
  }
  Then { reduced_called_expression.inspect == "inc[inc[zero]]" }    
  
end