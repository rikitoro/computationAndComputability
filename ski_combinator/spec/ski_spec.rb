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