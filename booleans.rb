Object.send(:remove_const, :TRUE)
Object.send(:remove_const, :FALSE)

TRUE  = -> x { -> y { x } }
FALSE = -> x { -> y { y } }

IF = -> b { b }

def to_boolean(proc)
  IF[proc][true][false]
end
