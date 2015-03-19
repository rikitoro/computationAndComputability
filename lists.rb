require_relative 'pairs'
require_relative 'booleans'
require_relative 'numeric_operations'

EMPTY     = PAIR[TRUE][TRUE]
UNSHIFT   = -> l { -> x { PAIR[FALSE][PAIR[x][l]] } }
IS_EMPTY  = LEFT
FIRST     = -> l { LEFT[RIGHT[l]] }
REST      = -> l { RIGHT[RIGHT[l]]}

COUNTDOWN = -> p { PAIR[UNSHIFT[LEFT[p]][RIGHT[p]]][DECREMENT[RIGHT[p]]] }

RANGE =
  -> m { -> n {
    LEFT[INCREMENT[SUBTRACT[n][m]][COUNTDOWN][PAIR[EMPTY][n]]]
  } }
=begin
RANGE =
  Z[-> f { 
    -> m { -> n { 
      IF[IS_LESS_OR_EQUAL[m][n]][
        -> x {
          UNSHIFT[f[INCREMENT[m]][n]][m][x]
        }
      ][
        EMPTY
      ]
    } } 
  }]
=end

FOLD =
  Z[-> f {
    -> l { -> x { -> g { 
      IF[IS_EMPTY[l]][
        x
      ][
        -> y {
          g[f[REST[l]][x][g]][FIRST[l]][y]
        }
      ]
    } } }
  }]

MAP = 
  -> k { -> f { 
    FOLD[k][EMPTY][-> l { -> x { UNSHIFT[l][f[x]] } }]
  } }

def to_array(proc, count = nil)
  array = []

  until to_boolean(IS_EMPTY[proc]) || count == 0
    array.push(FIRST[proc])
    proc = REST[proc]
    count = count - 1 unless count.nil?
  end

  array
end