require_relative 'fundamental'

def two
  increment(increment(zero))
end

def three
  increment(two)
end

def add_three(x)
  increment(increment(increment(x)))
end