require_relative 'lists'

ZEROS = Z[-> f { UNSHIFT[f][ZERO] }]

UPWARDS_OF = Z[-> f { -> n { UNSHIFT[-> x { f[INCREMENT[n]][x] }][n] } }]

MULTIPLES_OF =
  -> m {
    Z[-> f { 
      -> n { UNSHIFT[->x { f[ADD[m][n]][x] }][n] }
    }][m]
  }