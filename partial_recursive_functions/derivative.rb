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

###

def add_zero_to_x(x)
  x
end

def increment_easier_result(x, eaiser_y, easier_result)
  increment(easier_result)
end

def add(x, y)
  recurse(:add_zero_to_x, :increment_easier_result, x, y)
end