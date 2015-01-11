converter = new Markdown.Converter()
markdown = (s) -> converter.makeHtml(s)

code = ''
textarea = undefined
outputarea = undefined
showHideCodeButton = undefined

hideCodeText = 'Hide code'
showCodeText = 'Show code'

window.App =
  hello: ->
    textarea = $('#source textarea')

    outputarea = $('#output')

    showHideCodeButton = $('button')
    showHideCodeButton.text(hideCodeText)
    showHideCodeButton.click(showOrHideCode)

    setInterval(possiblyUpdate, 2000)

possiblyUpdate = ->
  return if code == textarea.val()

  console.log('blah')
  code = textarea.val()
  md = markdown(code)
  outputarea.find('.output').html(md)
  js = ''
  n = 0
  $('#output .output code').parent('pre').replaceWith(-> (
    js += $(this).children().text()
    replacement = $('<div>')
    replacement.attr('id', 'js' + (n++))
    replacement
  ))

  f = eval('(function() {' + js + '})')
  run(f, $('#js0'))

showOrHideCode = (-> (
  showing = true
  (_) -> (
    button = showHideCodeButton
    if showing
      $("#source").fadeOut ->
        outputarea.removeClass 'col-xs-6'
        outputarea.addClass 'col-xs-12'
      button.text(showCodeText)
    else
      outputarea.removeClass 'col-xs-12'
      outputarea.addClass 'col-xs-6'
      $("#source").fadeIn()
      button.text hideCodeText
    showing = !showing
  )
))()
