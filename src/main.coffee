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

    outputarea = $('#output .output')

    showHideCodeButton = $('button')
    showHideCodeButton.text(hideCodeText)
    showHideCodeButton.click(showOrHideCode)

    setInterval(possiblyUpdate, 2000)

possiblyUpdate = ->
  return if code == textarea.val()

  code = textarea.val()
  md = markdown(code)
  outputarea.find('.output').html(md)
  js = []
  n = 0
  $('#output .output code').parent('pre').replaceWith(-> (
    console.log('blah')
    js.push($(this).children().text())
    replacement = $('<div>')
    replacement.attr('id', 'js' + (n++))
    replacement
  ))

  n = 0
  for j in js
    f = eval('(function() {' + j + '})')
    run(f, $('#js' + (n++)))

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
