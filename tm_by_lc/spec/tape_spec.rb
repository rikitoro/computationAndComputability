require 'rspec/given'
require_relative '../tape'

describe "TAPE" do
  Given(:initial_tape) { TAPE[EMPTY][ZERO][EMPTY][ZERO] }
  When(:current_tape) {
    tape = TAPE_WRITE[initial_tape][ONE]
    tape = TAPE_MOVE_HEAD_RIGHT[tape]
    tape = TAPE_WRITE[tape][TWO]
    tape = TAPE_MOVE_HEAD_RIGHT[tape]
    tape = TAPE_WRITE[tape][THREE]
    TAPE_MOVE_HEAD_RIGHT[tape]
  }

  Then { to_array(TAPE_LEFT[current_tape]).map { |p| to_integer(p) } == [1, 2, 3] }
  Then { to_integer(TAPE_MIDDLE[current_tape]) }
  Then { to_array(TAPE_RIGHT[current_tape]).map { |p| to_integer(p) } == [] }
end