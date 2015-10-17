var M = require('../src/main');
var assert = require("chai").assert;
var _ = require("lodash");

describe("Easy", function(){  
  var body, firstDiv, secondDiv, thirdDiv;

  before(function(done) {
    var htmlpath = __dirname+'/../easy.html';
    var csspath = __dirname+'/../easy.css';
    M.stylize(htmlpath, csspath, function(dom) {
      var layout = M.createLayout(dom);
      var dimensioned = M.calculateDimensions(M.viewport({width: 1440}), layout);
      body = dimensioned[0].children[2];
      firstDiv = body.children[0];
      secondDiv = firstDiv.children[0];
      thirdDiv = body.children[1];
      console.log("LAYOUT", M.print(dimensioned))
      // console.log("firstDiv", firstDiv);
      // console.log("secondDiv", secondDiv);
      // console.log("thirdDiv", thirdDiv);
      done();
    });
  });

  it('sets the body width and height', function(){
    assert.equal(body.dimensions.content.width, 1424);
    assert.equal(body.dimensions.content.height, 600);
  });

  it('sets the firstDiv width and height', function(){
    assert.equal(firstDiv.dimensions.content.width, 300);
    assert.equal(firstDiv.dimensions.content.height, 100);
  });

  it('sets the secondDiv width and height', function(){
    assert.equal(secondDiv.dimensions.content.width, 300);
    assert.equal(secondDiv.dimensions.content.height, 100);
  });

  it('sets the thirdDiv width and height', function(){
    assert.equal(thirdDiv.dimensions.content.width, 1424);
    assert.equal(thirdDiv.dimensions.content.height, 500);
  });
});
