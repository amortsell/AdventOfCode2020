var readline = require('linebyline');
let leftParenthesis = 0;
let sum = 0;
var evalExpression1 = function(tokens) {
  let tmpTokens = []
  for (let i = 0; i < tokens.length; i++) {
    if (Array.isArray(tokens[i])) {
      tmpTokens.push(evalExpression1(tokens[i]));
    } else {
      tmpTokens.push(tokens[i]);
    }

    if (tmpTokens.length === 3) {
      let op1 = parseInt(tmpTokens[0]), op2 = parseInt(tmpTokens[2]);
      let result = 0;
      switch(tmpTokens[1]) {
        case '+': 
          result = op1 + op2;
          break;
        case '*':
          result = op1 * op2;
          break;
      }
      tmpTokens = [result];
    }
  }

  if (tmpTokens.length === 1) {
    return tmpTokens[0];
  }

  return NaN;
}

var evalExpression2 = function(tokens) {
  let orderedTokens = [];
  let tmpTokens = [];
  let lastOp = '+';
  for (let i = 0; i < tokens.length; i++) {
    if (tokens[i] === '*') {
      orderedTokens.push(evalExpression1(tmpTokens));
      orderedTokens.push(tokens[i]);
      tmpTokens = [];
    } else if (tokens[i] === '+') {
      tmpTokens.push(tokens[i]);
    } else {
      if (Array.isArray(tokens[i])) {
        tmpTokens.push(evalExpression2(tokens[i]));
      } else {
        tmpTokens.push(tokens[i]);
      }
    }
  }

  orderedTokens.push(evalExpression1(tmpTokens));
  tmpTokens = [];
  for (let i = 0; i < orderedTokens.length; i++) {
    tmpTokens.push(orderedTokens[i]);

    if (tmpTokens.length === 3) {
      let op1 = parseInt(tmpTokens[0]), op2 = parseInt(tmpTokens[2]);
      let result = 0;
      switch(tmpTokens[1]) {
        case '+': 
          result = op1 + op2;
          break;
        case '*':
          result = op1 * op2;
          break;
      }
      tmpTokens = [result];
    }
  }

  if (tmpTokens.length === 1) {
    return tmpTokens[0];
  }

  return NaN;
}

var parseExpression = function(strExpr, initialLeftParenthesis) {
  let tokens = []
  while (strExpr.length > 0) {
    if (strExpr[0] == '(') {
      let result = parseExpression(strExpr.substring(1), ++leftParenthesis)
      tokens.push(result.tokens);
      strExpr = result.remainingString;
    } else if (strExpr[0] === '+' || strExpr[0] === '*') {
      tokens.push(strExpr[0]);
      strExpr = strExpr.substring(1).trimLeft();
    } else if (strExpr[0] === ')') {
      if (leftParenthesis-- === initialLeftParenthesis) {
        return {
          tokens: tokens,
          remainingString: strExpr.substring(1).trimLeft()
        }
      }
    } else {
      let num = '', i = 0
      while (/\d/.test(strExpr[i])) {
        num += strExpr[i++];
      }
      tokens.push(num);
      strExpr  = strExpr.substring(i).trimLeft();
    }
  }

  return {
    tokens: tokens,
    remainingString: ''
  }
}


var aoc18_1 = function() {
  const rl = readline('./arithmetic expressions day 18.txt');
  
  rl.on('line', line => {
    let result = parseExpression(line, 0).tokens;
    sum += evalExpression1(result);
  });
  
  rl.on('end', () => {
    console.log(sum);
  });
}

var aoc18_2 = function() {
  const rl = readline('./arithmetic expressions day 18.txt');
  
  rl.on('line', line => {
    let result = parseExpression(line, 0).tokens;
    sum += evalExpression2(result);
  });
  
  rl.on('end', () => {
    console.log(sum);
  });
}

module.exports = (function () {
  return {
    aoc18_1: aoc18_1,
    aoc18_2: aoc18_2
  }
})();