require 'rspec/given'
require_relative '../fizzbuzz'

def fb(n)
  return 'FizzBuzz' if n % 15 == 0
  return 'Fizz'     if n % 3  == 0
  return 'Buzz'     if n % 5  == 0
  n.to_s
end

describe "FizzBuzzSolution" do
  Then { to_array(FizzBuzzSolution[FIFTEEN]).map { |p| to_string(p) } == 
  (1..15).map { |n| fb(n) } }
  Then { to_array(FizzBuzzSolution[MULTIPLY[TWO][FIFTEEN]]).map { |p| to_string(p) } == 
  (1..30).map { |n| fb(n) } }
  Then { to_array(FizzBuzzSolution[HUNDRED]).map { |p| to_string(p) } == 
  (1..100).map { |n| fb(n) } }
end