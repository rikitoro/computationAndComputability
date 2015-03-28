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
