code = '';
textarea = undefined;
outputarea = undefined;

window.App = {
  hello: -> (
    textarea = $('<textarea rows="15" cols="100">');
    textarea.appendTo('#App');

    outputarea = $('<div>');
    outputarea.append('(this is the output area)');
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
