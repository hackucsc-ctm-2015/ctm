window.App = {
  hello: -> (
    textarea = $('<textarea rows="15" cols="100">');
    textarea.appendTo('#App');

    outputarea = $('<div>');
    outputarea.append('(this is the output area)');
    outputarea.appendTo('#App');
  )
}
