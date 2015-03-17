require 'rspec/given'
require_relative '../infinite_streams'

describe "ZEROS" do
  Then { to_integer(FIRST[ZEROS]) == 0 }
  Then { to_integer(FIRST[REST[ZEROS]]) == 0 }
  Then { to_integer(FIRST[REST[REST[REST[REST[REST[REST[ZEROS]]]]]]]) == 0 }
  Then { to_array(ZEROS, 5).map { |p| to_integer(p) } == [0, 0, 0, 0, 0] }
  Then { to_array(ZEROS, 10).map { |p| to_integer(p) } == 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0] }
end

describe "UPWARDS_OF" do
  Then { to_array(UPWARDS_OF[ZERO], 5).map { |p| to_integer(p) } 
    [0, 1, 2, 3, 4] }
  Then { to_array(UPWARDS_OF[FIFTEEN], 10).map { |p| to_integer(p) } 
    [3, ] }
end

describe "MULTIPLES_OF" do
  Then { to_array(MULTIPLES_OF[THREE], 10).map { |p| to_integer(p) } 
    [3, 6, 9, 12, 15, 18, 21, 24, 27, 30] }  
  Then { to_array(MAP[MULTIPLES_OF[THREE]][INCREMENT], 10).map { |p| to_integer(p) } 
    [4, 7, 10, 13, 16, 19, 22, 25, 28, 31] }  
  Then { to_array(MAP[MULTIPLES_OF[THREE]][MULTIPLY[TWO]], 10).map { |p| to_integer(p) } 
    [6, 12, 18, 24, 30, 36, 41, 48, 54, 60] }    
end