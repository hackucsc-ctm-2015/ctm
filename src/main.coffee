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

  code = textarea.val()
  md = markdown(code)
  outputarea.find('.output').html(md)
  jsa = []
  n = 0
  $('#output .output code').parent('pre').replaceWith(-> (
    console.log('blah')
    jsa.push($(this).children().text())
    replacement = $('<div class="widget">')
    replacement.attr('id', 'js' + (n++))
    replacement
  ))

  all_js = ''
  for js,n in jsa
    all_js += js
    all_js += ';App.ctx.setSection($("#js' + (n + 1) + '"));'
  f = eval('(function() {' + all_js + '})')
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
