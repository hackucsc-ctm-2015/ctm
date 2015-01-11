chai.should()

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
    $('#output input').attr 'value', '10'
    # $('#output pre').html().should.be.equal '10'
