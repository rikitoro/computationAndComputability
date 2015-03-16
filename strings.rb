require_relative 'lists'

TEN = MULTIPLY[TWO][FIVE]
B   = TEN
F   = INCREMENT[B]
I   = INCREMENT[F]
U   = INCREMENT[I]
ZED = INCREMENT[U]

FIZZ      = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ      = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
FIZZBUZZ  = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

DIV =
  Z[->f { 
    -> m { -> n { 
      IF[IS_LESS_OR_EQUAL[n][m]][
        -> x {
          INCREMENT[f[SUBTRACT[m][n]][n]][x]
        }
      ][
        ZERO
      ]
    } }
  }]

PUSH =
  -> l {
    -> x {
      FOLD[l][UNSHIFT[EMPTY][x]][UNSHIFT]
    }
  }

TO_DIGITS =
  Z[-> f { 
    -> n {
      PUSH[
        IF[IS_LESS_OR_EQUAL[n][DECREMENT[TEN]]][
          EMPTY
        ][
          -> x {
            f[DIV[n][TEN]][x]
          }
        ]
      ][MOD[n][TEN]]
    }
  }]


def to_char(c)
  '0123456789BFiuz'.slice(to_integer(c))
end

def to_string(s)
  to_array(s).map { |c| to_char(c) }.join  
end