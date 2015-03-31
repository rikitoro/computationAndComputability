require 'rspec/given'
require 'treetop'

require_relative '../ski'
require_relative '../lc'

Treetop.load('lambda_calculus')


describe "iota" do
  context "S.to_iota ---> S" do
    subject(:subject) { S.to_iota }
    When(:reduced_expression) {
      expr = subject
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'S' }
  end

  context "K.to_iota ---> K" do
    subject(:subject) { K.to_iota }
    When(:reduced_expression) {
      expr = subject
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'K' }
  end

  context "I.to_iota ---> S[K][K[K]]" do
    subject(:subject) { I.to_iota }
    When(:reduced_expression) {
      expr = subject
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'S[K][K[K]]' }
  end

  context "identity = S[K][K[K]] works as I, i.e. identity[x] ---> x" do
    Given(:x) { SKISymbol.new(:x) }
    Given(:identity) { SKICall.new(SKICall.new(S, K), SKICall.new(K, K)) }
    subject(:expression) { SKICall.new(identity, x) }
    When(:reduced_expression) {
      expr = expression
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'x' }
  end

  context "two = -> p { -> x { p[p[x]] } }" do
    Given(:two) { LambdaCalculusParser.new.parse('-> p { -> x { p[p[x]] } }').to_ast }
    Given(:inc) { SKISymbol.new(:inc) }
    Given(:zero) { SKISymbol.new(:zero) }
    When(:expression) { SKICall.new(SKICall.new(two.to_ski.to_iota, inc), zero) }
    When(:reduced_expression) {
      expr = expression
      expr = expr.reduce while expr.reducible?
      expr
    }
    Then { reduced_expression.inspect == 'inc[inc[zero]]'}
  end
end