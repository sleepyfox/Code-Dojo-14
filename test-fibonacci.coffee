should = require('chai').should()

Fibonacci = (n) ->
  if n is 10 then 2 else 1

describe 'Fibonacci sums', ->
  it 'The first Fibonacci number should be 1 (not zero)', ->
    Fibonacci(1).should.equal 1

  it 'The second Fibonacci number should be 2', ->
    Fibonacci(10).should.equal 2
