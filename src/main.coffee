converter = new Markdown.Converter()
markdown = (s) -> converter.makeHtml(s);

code = ''
textarea = undefined
outputarea = undefined
showHideCodeButton = undefined

hideCodeText = 'Hide code'
showCodeText = 'Show code'

window.App = {
  hello: -> (
    textarea = $('<textarea>')
    textarea.css({
      position: 'absolute'
      right:    '0'
      width:    '50%'
      height:   '98%'
    })
    textarea.appendTo('#App')

    textarea.appendTo('#App')

    outputarea = $('<div>')
    outputarea.attr('id', 'outputarea');
    outputarea.html(markdown('hello *world*'))
    outputarea.css
      position: 'absolute'
      width:    '50%'
      top:      '1.5em'
      bottom:   '0'
    outputarea.appendTo('#App')

    showHideCodeButton = $('<button>')
    showHideCodeButton.text(hideCodeText)
    showHideCodeButton.click(showOrHideCode)
    showHideCodeButton.appendTo('#App')

    setInterval(possiblyUpdate, 2000)
  )
}

possiblyUpdate = -> (
  if(code == textarea.val())
    return

  console.log('blah')
  code = textarea.val()
  execute(code)
)

execute = (code) -> (
  md = markdown(code);
  outputarea.html(md);
  js = '';
  n = 0;
  $('#outputarea code').parent('pre').replaceWith(-> (
    js += $(this).children().text()
    replacement = $('<div>')
    replacement.attr('id', 'js' + n)
    replacement
  ))

  f = eval('(function() {' + js + '})')
  run(f, $('#js0'))
)

showOrHideCode = (-> (
  showing = true
  (_) -> (
    button = showHideCodeButton
    if(showing)
      textarea.detach()
      outputarea.css('width', '100%')
      button.text(showCodeText)
    else
      textarea.appendTo('#App')
      outputarea.css('width', '50%')
      button.text(hideCodeText)
    showing = !showing
  )
))()
