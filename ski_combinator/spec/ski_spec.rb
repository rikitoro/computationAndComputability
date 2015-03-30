require 'rspec/given'
require_relative '../ski'

describe SKICall do
  subject(:subject) { SKISymbol.new(:x) }
  Then { subject.inspect == 'x' }
end

describe SKICall do
  subject(:subject) { SKICall.new(SKICall.new(S, K), SKICall.new(I, :x)) }
  Then { subject.inspect == 'S[K][I[x]]' }
end

describe SKICombinator do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }
  Given(:z) { SKISymbol.new(:z) }
  subject(:subject) { S.call(x, y, z) }
  Then { subject.inspect == 'x[z][y[z]]' }
end

describe "#combinator and #arguments" do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }
  Given(:z) { SKISymbol.new(:z) }
  subject(:subject) { SKICall.new(SKICall.new(SKICall.new(S, x), y), z) }
  When(:combinator) { subject.combinator }
  When(:arguments) { subject.arguments }
  Then { combinator.call(*arguments).inspect == 'x[z][y[z]]' }
end

describe "#callable?" do
  Given(:x) { SKISymbol.new(:x) }
  Given(:y) { SKISymbol.new(:y) }
  Given(:z) { SKISymbol.new(:z) }

  context "x[y][z]" do
    subject(:subject) { SKICall.new(SKICall.new(x, y), z) }
    Then { subject.combinator.callable?(*subject.arguments) == false }
  end

  context "S[x][y]" do
    subject(:subject) { SKICall.new(SKICall.new(S, x), y) }
    Then { subject.combinator.callable?(*subject.arguments) == false }     
  end

  context "S[x][y][z]" do
    subject(:subject) { SKICall.new(SKICall.new(SKICall.new(S, x), y), z) }
    Then { subject.combinator.callable?(*subject.arguments) == true }     
  end

end
