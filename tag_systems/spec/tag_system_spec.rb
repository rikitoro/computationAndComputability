require 'rspec/given'
require_relative '../tag_system'

describe TagSystem do
  context "double the number 3(aabbbbbb) to 6(aabbbbbbbbbbbb)" do
    Given(:rulebook) { TagRulebook.new(2, [TagRule.new('a', 'aa'), TagRule.new('b', 'bbbb')]) }
    subject(:subject) { TagSystem.new('aabbbbbb', rulebook) }
    When { 4.times { subject.step } }
    Then { subject.current_string == 'aabbbbbbbbbbbb' }
  end

  context "double the number 3(aabbbbbb) to 6(ccdddddddddddd)" do
    Given(:rulebook) { TagRulebook.new(2, [TagRule.new('a', 'cc'), TagRule.new('b', 'dddd')]) }
    subject(:subject) { TagSystem.new('aabbbbbb', rulebook) }
    When { subject.run }
    Then { subject.current_string == 'ccdddddddddddd' }
  end

end