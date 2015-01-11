chai.should()
expect = chai.expect

describe 'Label', ->

  it 'should print values', ->
    run ->
      a = 23
      print a
    printOut = $('#output pre')
    printOut.get().should.have.length 1
    printOut.html().should.be.equal '23'

describe 'Slider', ->

  it 'should create an input element', ->
    run ->
      slider 0, 100, 1
    widget = $('#output input')
    widget.get().should.have.length 1
    widget.val().should.be.equal '50'

  it 'should update on change', ->
    run ->
      a = slider 0, 100, 1
      print a
    $('#output pre').html().should.be.equal '50'
    $('#output input').val 10
    $('#output input').trigger 'change'
    $('#output pre').html().should.be.equal '10'

  it 'should complain about too many widgets on update', ->
    num = 1
    run ->
      for i in [0..num]
        slider 0, 10, 1
    num = 3
    $('#output input').val 3
    expect(-> $('#output input').trigger 'change').to.throw()

  it 'should complain about too few widgets on update', ->
    num = 3
    run ->
      for i in [0..num]
        slider 0, 10, 1
    num = 1
    $('#output input').val 3
    expect(-> $('#output input').trigger 'change').to.throw()

