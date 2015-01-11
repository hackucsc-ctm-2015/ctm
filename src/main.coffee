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
    outputarea.append('(this is the output area)')
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
  s = code.split('').reverse().join('')
  outputarea.text(s)
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
