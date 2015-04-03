require 'rspec/given'
require_relative '../tag_system'

describe "cyclic tag system" do
  Given(:rulebook) { CyclicTagRulebook.new([
    CyclicTagRule.new('1'), CyclicTagRule.new('0010'),
    CyclicTagRule.new('10')
    ]) }
  subject(:subject) { TagSystem.new('11', rulebook) }

  context "after 16 step" do
    When { 16.times { subject.step } }
    Then { subject.current_string == '00101' }    
  end

  context "after 16 step" do
    When { 36.times { subject.step } }
    Then { subject.current_string == '101' }    
  end


end