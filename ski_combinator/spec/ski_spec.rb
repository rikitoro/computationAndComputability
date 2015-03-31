require 'rspec/given'
require_relative '../ski'

describe SKICall do
  subject(:subject) { SKISymbol.new(:x) }
  Then { subject.inspect == 'x' }
end

describe SKICall do
  subject(:subject) { SKICall.new(SKICall.new(S, K), SKICall.new(I, :x)) }
  Then { subject.inspect == 'S[K][I[x]]' }
end

describe SKICombinator do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }
  Given(:z) { SKISymbol.new(:z) }
  subject(:subject) { S.call(x, y, z) }
  Then { subject.inspect == 'x[z][y[z]]' }
end

describe "#combinator and #arguments" do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }
  Given(:z) { SKISymbol.new(:z) }
  subject(:subject) { SKICall.new(SKICall.new(SKICall.new(S, x), y), z) }
  When(:combinator) { subject.combinator }
  When(:arguments) { subject.arguments }
  Then { combinator.call(*arguments).inspect == 'x[z][y[z]]' }
end

describe "#callable?" do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }
  Given(:z) { SKISymbol.new(:z) }

  context "x[y][z]" do
    subject(:subject) { SKICall.new(SKICall.new(x, y), z) }
    Then { subject.combinator.callable?(*subject.arguments) == false }
  end

  context "S[x][y]" do
    subject(:subject) { SKICall.new(SKICall.new(S, x), y) }
    Then { subject.combinator.callable?(*subject.arguments) == false }     
  end

  context "S[x][y][z]" do
    subject(:subject) { SKICall.new(SKICall.new(SKICall.new(S, x), y), z) }
    Then { subject.combinator.callable?(*subject.arguments) == true }     
  end
end

describe "swap operation" do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }  
  Given(:swap) { SKICall.new(SKICall.new(S, SKICall.new(K, SKICall.new(S,I))), K) }
  Given(:expression) { SKICall.new(SKICall.new(swap, x), y) }
  context "S[K[S[I]]][K][x][y] ---> y[x]" do
    When(:reduced_expression) {
      expr = expression
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'y[x]' }    
  end
end

describe "#as_a_function_of" do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }  

  context "S[K][I] - as_a_function_of -> S[S[K[S]][K[K]]][K[I]]" do
    Given(:original) { SKICall.new(SKICall.new(S, K), I) }
    When(:function) { original.as_a_function_of(:x) }
    Then { function.inspect == 'S[S[K[S]][K[K]]][K[I]]' }
    Then { function.reducible? == false } 
  end


  context "S[K][I] - as_a_function_of -> expression; expression[y] ---> S[K][I] " do
    Given(:original) { SKICall.new(SKICall.new(S, K), I) }
    When(:function) { original.as_a_function_of(:x) }
    When(:expression) { SKICall.new(function, y) }
    When(:reduced_expression) {
      expr = expression
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'S[K][I]' }
    Then { reduced_expression == original }
  end

  context "S[x][I] - as_a_function_of -> expression; expression[y] ---> S[y][I]" do
    Given(:original) { SKICall.new(SKICall.new(S, x), I) }
    When(:function) { original.as_a_function_of(:x) }
    When(:expression) { SKICall.new(function, y) }
    When(:reduced_expression) {
      expr = expression
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'S[y][I]' }
    Then { reduced_expression != original }        
  end


end