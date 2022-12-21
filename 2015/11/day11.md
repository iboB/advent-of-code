Solved without code. Just looking and analyzing.

The input was `cqjxjnds`

## Part 1

1. `cqj` is a valid start
2. Smallest lexicographic ending for remaining 5 characters is `aabcc`
3. First character is `x`
4. => `xxyzz`
5. `cqjxxyzz`

## Part 2

1. `xxyzz` overflows leading to `cqk` or `cqkaaaaa` for the whole pass
2. The same as Part 1, point 2
3. `cqkaabcc`
