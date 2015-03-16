require 'rspec/given'
require_relative '../lists'
require_relative '../numbers'

describe "lists" do
  subject(:subject) { 
    UNSHIFT[
      UNSHIFT[
        UNSHIFT[EMPTY][THREE] 
      ][TWO]
    ][ONE]
  }

  Then { to_integer(FIRST[subject]) == 1 }
  Then { to_integer(FIRST[REST[subject]]) == 2}
  Then { to_integer(FIRST[REST[REST[subject]]]) == 3}
  Then { to_boolean(IS_EMPTY[subject]) == false }
  Then { to_boolean(IS_EMPTY[EMPTY]) == true }
  Then { to_array(subject).map { |p| to_integer(p) } == [1, 2, 3] }
end

describe "range" do
  subject(:subject) { RANGE[ONE][FIVE] }
  Then { to_array(subject).map { |p| to_integer(p) } == 
    [1, 2, 3, 4, 5] }
end

describe "fold" do
  Then { to_integer(FOLD[RANGE[ONE][FIVE]][ZERO][ADD]) == 15 }
  Then { to_integer(FOLD[RANGE[ONE][FIVE]][ONE][MULTIPLY]) == 120}  
end