require 'rspec/given'
require_relative '../tag_system'

describe TagSystem do
  context "double the number 3(aabbbbbb)" do
    Given(:rulebook) { TagRulebook.new(2, [TagRule.new('a', 'aa'), TagRule.new('b', 'bbbb')]) }
    subject(:subject) { TagSystem.new('aabbbbbb', rulebook) }
    When { 4.times { subject.step } }
    Then { subject.current_string == 'aabbbbbbbbbbbb' }
  end
end