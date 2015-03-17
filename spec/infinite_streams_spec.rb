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