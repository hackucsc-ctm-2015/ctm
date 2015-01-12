diskOutdated = false
renderOutdated = true

converter = new Markdown.Converter()
markdown = (s) -> converter.makeHtml(s)

code = """
# Bouncing ball

The **gravitational force** will accelerate an object starting at a certain
height.

Gravity (0-10, Earth surface would be about 9.81):

    var gravity = slider(0, 10, 0.1, 1.5);

Starting Height (0-100m):

    var start = slider(0, 100, 1, 100);

Upon hitting the ground, a portion of the *kinetic energy* will be lost, so a
*bouncing ball* will be jump back up with less velocity than before.

Bounce factor (0.0 - 1.0):

    var bounce = slider(0, 1, 0.1, 0.8);

Additionally, drag in term of *air resistance/friction* will also slow down the
obj.  The amount of drag affecting an object is usually linear with its
velocity which caps the acceleration due to graviation at a certain **terminal
velocity**.

Drag (0-10%):

    var drag = 1 - slider(0, 0.1, 0.0001, 0);

The simulation itself is fairly straight-forward.

    var height = [], velocity = [], v = 0, h = start;
    for (var i = 0; i < 100; i++) {
      v -= gravity;
        v *= drag;
        h += v;
        if (h < 0) { v = -v * bounce; h = 0; }
        velocity.push(Math.abs(v));
        height.push(h);
    }

Plotting the height of the bouncing ball over time looks like a series of
inverted parables:

    plotseries(height);

By plotting the velocity, it is possible to understand the effects of
gravitation and drag on the momentum:

    plotseries(velocity);"""

textarea = undefined
outputarea = undefined
showCodeButton = undefined
hideCodeButton = undefined
filePicker = undefined

window.addEventListener('beforeunload', (e) ->
  if diskOutdated
    e.returnValue = 'Are you sure you want to leave this page?'
)

window.App =
  init: ->
    textarea = CodeMirror $('#source .panel-body').get(0),
      value: code
      mode: 'markdown'
      indentUnit: 4

    outputarea = $('#output')

    showCodeButton = $('#showCodeButton')
    hideCodeButton = $('#hideCodeButton')
    showCodeButton.click(showCode)
    hideCodeButton.click(hideCode)

    $('#loadButton').click(load)
    filePicker = $('#filePicker')
    filePicker.on('change', load2)

    $('#saveButton').click(save)

    setInterval(possiblyUpdate, 2000)

    $("#vimmode").on "change", ->
      console.log $("#vimmode").is(":checked")
      textarea.setOption 'vimMode', $("#vimmode").is(":checked")

possiblyUpdate = ->
  if code != textarea.getValue()
    diskOutdated = true
    renderOutdated = true
  code = textarea.getValue()

  return if !renderOutdated

  renderOutdated = false

  md = markdown(code)
  outputarea.find('.output').html(md)
  jsa = []
  n = 0
  $('#output .output code').parent('pre').replaceWith(-> (
    jsa.push($(this).children().text())
    replacement = $('<div class="widget">')
    replacement.attr('id', 'js' + (n++))
    replacement
  ))

  if jsa.length == 0
    return

  all_js = ''
  for js,n in jsa
    all_js += js
    all_js += ';App.ctx.setSection($("#js' + (n + 1) + '"));'

  try
    f = eval('(function() {' + all_js + '})')
  catch e
    error = $('<p style="color:red;">')
    error.text(e.toString())
    $('#js0').append error
    return

  run(f, $('#js0'))  if jsa.length > 0

hideCode = ->
  $('#source').fadeOut ->
    outputarea.removeClass 'col-xs-6'
    outputarea.addClass 'col-xs-12'
  showCodeButton.fadeIn()

showCode = ->
  outputarea.removeClass 'col-xs-12'
  outputarea.addClass 'col-xs-6'
  $('#source').fadeIn()
  showCodeButton.fadeOut()

load = ->
  if diskOutdated
    if !window.confirm('Are you sure you want to load a new file without' +
                       'saving this one first?')
      return
  filePicker[0].click()

load2 = ->
  file = filePicker[0].files[0]
  if file == undefined
    console.log('file is undefined')
    return
  reader = new FileReader()
  reader.onload = (_) ->
    if reader.result == undefined
      console.log('file contents are undefined')
      return

    # Populate the text field with the new source code
    code = reader.result
    textarea.setValue(reader.result)
    diskOutdated = false
    renderOutdated = true

  reader.readAsText(file)

save = ->
  console.log('attempting to save')
  download('file.ctm', textarea.getValue())

download = (filename, text) ->
  a = $('<a>')
  a.attr
    href: 'data:text/plain;charset=utf-8,' + encodeURIComponent(text)
    download: filename
  a.appendTo($('body'))
  a[0].click()
  a.remove()
  diskOutdated = false
