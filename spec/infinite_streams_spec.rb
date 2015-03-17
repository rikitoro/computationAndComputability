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
    [15, 16, 17, 18, 19, 20, 21, 22, 23,24] }
end