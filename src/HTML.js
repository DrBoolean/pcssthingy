var htmlparser = require('htmlparser');

function parse(html, cb) {
  var handler = new htmlparser.DefaultHandler(function (error, dom) {
    if (error) console.log(error)
    cb(dom)();
  }, { verbose: false, ignoreWhitespace: true } );
  var parser = new htmlparser.Parser(handler);
  parser.parseComplete(html);
}

// module HTML
exports.parse = parse;
