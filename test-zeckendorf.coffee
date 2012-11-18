should = require('chai').should()

describe 'Zeckendorf', ->
  it '1 should return 1', ->
    zeckendorf = ->
      1
    zeckendorf(1).should.equal 1

