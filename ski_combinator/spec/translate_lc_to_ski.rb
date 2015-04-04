require 'rspec/given'
require 'treetop'
require_relative '../lc'

Treetop.load('lambda_calculus')

describe "translate lambda caluculus function to SKI combinator" do
  Given(:two) { LambdaCalculusParser.new.parse('-> p { -> x { p[p[x]] } }').to_ast }
  context "translate two = -> p { -> x { p[p[x]] } } to SKI" do
    When(:two_ski) { two.to_ski }
    Then { two_ski.inspect == 'S[S[K[S]][S[K[K]][I]]][S[S[K[S]][S[K[K]][I]]][K[I]]]' }  
  end

  Given(:inc) { SKISymbol.new(:inc) }
  Given(:zero) { SKISymbol.new(:zero) }
  context "translated -> p { -> x { p[p[x]] } } works correctly" do
    When(:expression) { SKICall.new(SKICall.new(two.to_ski, inc), zero) }
    When(:reduced_expression) {
      expr = expression
      while expr.reducible?
        expr = expr.reduce
      end
      expr
    }
    Then { reduced_expression.inspect == 'inc[inc[zero]]' }   
  end
end