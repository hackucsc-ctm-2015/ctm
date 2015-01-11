code = '';
textarea = undefined;
outputarea = undefined;

window.App = {
  hello: -> (
    textarea = $('<textarea>');
    textarea.css({
      position: 'absolute'
      right:    '0'
      width:    '50%'
      height:   '98%'
    });
    textarea.appendTo('#App');

    outputarea = $('<div>');
    outputarea.append('(this is the output area)');
    outputarea.css({
      position: 'absolute'
      left:     '50%'
      width:    '50%'
      height:   '100%'
    });
    outputarea.appendTo('#App');

    setInterval(possiblyUpdate, 2000);
  )
};

possiblyUpdate = -> (
  if(code == textarea.val())
    return;

  console.log('blah');
  code = textarea.val();
  execute(code);
);

execute = (code) -> (
  s = code.split('').reverse().join('');
  outputarea.text(s);
);
