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

###

def multiply_x_by_zero(x)
  zero
end

def add_x_to_easier_result(x, eaiser_y, easier_result)
  add(x, easier_result)
end

def multiply(x, y)
  recurse(:multiply_x_by_zero, :add_x_to_easier_result, x, y)
end


###

def six
  multiply(two, three)
end


###

def easier_x(easier_x, easier_result)
  easier_x
end

def decrement(x)
  recurse(:zero, :easier_x, x)
end


###

def subtract_zero_from_x(x)
  x
end

def decrement_easier_result(x, eaiser_y, easier_result)
  decrement(easier_result)
end

def subtract(x, y)
  recurse(:subtract_zero_from_x, :decrement_easier_result, x, y)
end