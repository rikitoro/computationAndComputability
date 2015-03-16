require_relative 'strings'

FizzBuzzSolution =
  MAP[RANGE[ONE][HUNDRED]][-> n {
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