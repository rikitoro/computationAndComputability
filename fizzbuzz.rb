require_relative 'strings'

FizzBuzzSolution =
  -> m {
    MAP[RANGE[ONE][m]][-> n {
      IF[IS_ZERO[MOD[n][FIFTEEN]]][
        FIZZBUZZ
      ][IF[IS_ZERO[MOD[n][THREE]]][
        FIZZ
      ][IF[IS_ZERO[MOD[n][FIVE]]][
        BUZZ
      ][
        TO_DIGITS[n]
      ]]]
    } ]
  }