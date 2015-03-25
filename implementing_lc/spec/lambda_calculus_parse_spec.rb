require 'rspec/given'
require 'treetop'
require_relative '../lc'

Treetop.load('lambda_calculus')

describe "LambdaCalculusParser" do
  subject(:parse_tree) { LambdaCalculusParser.new.parse('-> x { x[x] }[-> y { y }]') }
  When(:expression) { parse_tree.to_ast }
  context "to_ast" do
    Then { expression.inspect == '-> x { x[x] }[-> y { y }]' }  
  end
  context "reduced expression" do
    When(:reduced_expression) { expression.reduce }
    Then { reduced_expression.inspect == '-> y { y }[-> y { y }]' }
  end
end