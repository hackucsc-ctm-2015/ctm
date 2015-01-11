chai.should()

describe 'Label', ->

  it 'should print values', ->
    run ->
      a = 23
      print a
    printOut = $('#output pre')
    printOut.get().should.have.length 1
    printOut.html().should.be.equal '23'
