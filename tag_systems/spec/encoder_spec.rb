require 'rspec/given'
require_relative '../tag_system'

describe "encoder" do
  Given(:rulebook) { TagRulebook.new(2, [TagRule.new('a', 'ccdd'), TagRule.new('b', 'dd')]) }
  Given(:system) { TagSystem.new('aabbbb', rulebook) }
  Given(:encoder) { system.encoder }
  context "alphabet" do
    Then { system.alphabet == ['a', 'b', 'c', 'd'] }    
  end

  context "encoder" do
    Then { encoder.encode_character('c') == '0010' }
    Then { encoder.encode_string('cab') == '001010000100'}
  end

  context "to_cyclic" do
    Given(:cyclic_system) { system.to_cyclic }
    context "initial" do
      Then { cyclic_system.current_string == '100010000100010001000100' }
    end
    context "after 20 steps" do
      When { 20.times { cyclic_system.step } }
      Then { cyclic_system.current_string == '010000100010000100010001000100010001' }
    end
  end
end

