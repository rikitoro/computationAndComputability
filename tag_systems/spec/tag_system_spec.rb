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

  context "increments the number 2(aabbbb) to 3(ccdddddd)" do
    Given(:rulebook) { TagRulebook.new(2, [TagRule.new('a', 'ccdd'), TagRule.new('b', 'dd')]) }
    subject(:subject) { TagSystem.new('aabbbb', rulebook) }
    When { subject.run }
    Then { subject.current_string == 'ccdddddd' }    
  end

  context "double the number 2(aabbbb) to 4(ccdddddddd), and increments it to 5(eeffffffffff)" do
    Given(:rulebook) { TagRulebook.new(2, [
      TagRule.new('a', 'cc'), TagRule.new('b', 'dddd'),
      TagRule.new('c', 'eeff'), TagRule.new('d', 'ff')]) }
    subject(:subject) { TagSystem.new('aabbbb', rulebook) }
    When { subject.run }
    Then { subject.current_string == 'eeffffffffff' }    
  end

  context "tests whether a number is odd or even" do
    Given(:rulebook) { TagRulebook.new(2, [
      TagRule.new('a', 'cc'), TagRule.new('b', 'd'),
      TagRule.new('c', 'eo'), TagRule.new('d', ''),
      TagRule.new('e', 'e')]) }
    subject(:subject) { TagSystem.new(number_string, rulebook) }

    context "when the input represents an even number" do
      When(:number_string) { 'aabbbbbbbb' }
      When { subject.run }
      Then { subject.current_string == 'e' }
    end

    context "when the input represents an odd number" do
      When(:number_string) { 'aabbbbbbbbbb' }
      When { subject.run }
      Then { subject.current_string == 'o' }
    end
  end

end