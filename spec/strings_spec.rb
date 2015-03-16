require 'rspec/given'
require_relative '../strings'

describe "strings" do
  Then { to_char(ZED) == 'z' }
  Then { to_string(FIZZBUZZ) == 'FizzBuzz' }
end

describe "TO_DIGITS" do
  Then { to_array(TO_DIGITS[FIVE]).map { |p| to_integer(p) } == [5] }  
  Then { to_array(TO_DIGITS[POWER[FIVE][THREE]]).map { |p| to_integer(p) } == 
    [1, 2, 5] }
  Then { to_string(TO_DIGITS[FIVE]) == '5' }      
  Then { to_string(TO_DIGITS[FIFTEEN]) == '15' }  
end