should = require 'should'

pad = (string) ->
  while string.length < 6 # pad to six chars
    string = '0' + string
  return string

fibonacciList = (numberOfElements) ->
  for i in [0..numberOfElements - 1]
    switch i
      when 0
        list = [1]
      when 1
        list.push 2
      else
        list.push list[i - 1] + list[i - 2]
  return list

fibonacci = (number) ->
  sum = 0
  fibNums = fibonacciList(6).reverse()
  padded = pad(number)
  chars = padded.split ''
  for i in [0..5]
    if chars[i] is '1'
      sum += fibNums[i]
  return sum # a number

binary = (decimal) -> # returns string
  binaryString = decimal.toString 2

sumsFactory = (max) ->
  sums = {}
  for i in [1..max]
    sum = fibonacci binary i
    unless sums[sum]?
      sums[sum] = []
    sums[sum].push binary i
  return sums

zeckendorf = (string) ->
  if string.indexOf('11') is -1 then true else false


describe 'String padding', ->
  it 'an empty string should be padded to six zeroes', ->
    pad('').should.equal '000000'

  it 'a string of one character should be padded to six', ->
    pad('1').should.equal '000001'

  it 'a string of three characters should be padded to six', ->
    pad('101').should.equal '000101'

  it 'a string of six characters should be unaltered', ->
    pad('000000').should.equal '000000'

  it 'a string of seven characters should be unaltered', ->
    pad('0000001').should.equal '0000001'


describe 'Fibonacci sums', ->
  it 'The first Fibonacci number should be 1 (not zero)', ->
    fibonacci('1').should.equal 1

  it 'The second Fibonacci number should be 2', ->
    fibonacci('10').should.equal 2

  it 'The sum of the first and second Fibonacci numbers should be 3', ->
    fibonacci('11').should.equal 3

  it 'The third Fibonacci number should be 3', ->
    fibonacci('100').should.equal 3


describe 'Binary generator', ->
  it 'zero in binary is 0', ->
    binary(0).should.equal '0'

  it 'one in binary is 1', ->
    binary(1).should.equal '1'

  it 'two in binary is 10', ->
    binary(2).should.equal '10'

  it 'three in binary should be 11', ->
    binary(3).should.equal '11'

  it 'nine in binary should be 1001', ->
    binary(9).should.equal '1001'


describe 'Sum hash generator', ->
  it 'sums of 1..1 should be "1"', ->
    sums = sumsFactory 1
    sums[1][0].should.equal '1'

  it 'sums of 1..2 should be 1:["1"], 2:["10"]', ->
    sums = sumsFactory 2
    sums[2] = [binary 2]
    sums[1].should.have.length 1
    sums[1][0].should.equal '1'
    sums[2].should.have.length 1
    sums[2][0].should.equal '10'

  it 'sums of 1..3 should be 1:["1"], 2:["10"], 3:["100","11"]', ->
    sums = sumsFactory 4
    sums[1][0].should.equal '1'
    sums[2][0].should.equal '10'
    sums[3][1].should.equal '100'
    sums[3][0].should.equal '11'


describe 'Fibonacci list', ->
  it 'the first Fibonacci number should be 1 (not zero as traditionally)', ->
    list = fibonacciList 1
    list[0].should.equal 1

  it 'a list of one Fibonacci number should have one item in it', ->
    list = fibonacciList 1
    list.should.have.length 1

  it 'a list of two Fibonacci numbers should be 1 and 2', ->
    list = fibonacciList 2
    list[0].should.equal 1
    list[1].should.equal 2

  it 'a list of three Fibonacci numbers should be 1, 2 and 3', ->
    list = fibonacciList 3
    list[0].should.equal 1
    list[1].should.equal 2
    list[2].should.equal 3

  it 'a list of 20 Fibonacci numbers should have the 20th number being 10946', ->
    list = fibonacciList 20
    list[19].should.equal 10946


describe 'Zeckendorf filter', ->
  it '0 should  be a Zeckendorf number', ->
    zeckendorf('0').should.be.true

  it '1 should be a Zeckendorf number', ->
    zeckendorf('1').should.be.true

  it '11 should not be a Zeckendorf number', ->
    zeckendorf('11').should.be.false


main = do ->
  sums = sumsFactory 42 # first 20 decimals
  length = 0
  for key of sums
    outputString = "#{key}: "
    for i in sums[key]
      if zeckendorf i
        outputString += "#{i} "
        length++
    console.log outputString
  console.log length
