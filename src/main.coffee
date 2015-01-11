diskOutdated = false
renderOutdated = true

converter = new Markdown.Converter()
markdown = (s) -> converter.makeHtml(s)

code = '# Headline\n\nThis is some plain text.\n\n    print("Hello World");'
textarea = undefined
outputarea = undefined
showHideCodeButton = undefined
filePicker = undefined

hideCodeText = 'Hide code'
showCodeText = 'Show code'

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

    showHideCodeButton = $('#showHideCodeButton')
    showHideCodeButton.text(hideCodeText)
    showHideCodeButton.click(showOrHideCode)

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

showOrHideCode = (-> (
  showing = true
  (_) -> (
    button = showHideCodeButton
    if showing
      $('#source').fadeOut ->
        outputarea.removeClass 'col-xs-6'
        outputarea.addClass 'col-xs-12'
      button.text(showCodeText)
    else
      outputarea.removeClass 'col-xs-12'
      outputarea.addClass 'col-xs-6'
      $('#source').fadeIn()
      button.text hideCodeText
    showing = !showing
  )
))()

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
