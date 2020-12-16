var readline = require('linebyline');
var fs = require('fs');
const args = [ '10.2' ]; //process.argv.slice(2);
var day = args[0].split('.')[0];
var exercise = args[0].split('.')[1]

var aoc10_2 = function() {
  const rl = readline('./joltageinputs day 10.txt');
  
  this.inputs = [];
  this.tmp = []
  var self = this;
  rl.on('line' , line => {
    self.tmp.push(parseInt(line));
  });
  rl.on('end', () => {
    self.tmp.sort((a, b) => a - b)
    
    var split = false
    var start = 0
    for (var i = 0; i < self.tmp.length; i++) {
      if (i > 0 && i % 10 == 0) {
        split = true
      }

      if (split && self.tmp[i] - self.tmp[i - 1] == 3) {
        self.inputs.push(self.tmp.slice(start, i));
        start = i;
        split = false;
      }
    }

    self.inputs.push(self.tmp.slice(start));

    var countBranches = function(inputs, start, current) {
      count = 0
      var i = start;
      if (i >= inputs.length) {
        return 1;
      }
      
      while (inputs[i]  - current <= 3) {
        count += countBranches(inputs, i + 1, inputs[i++]);
      }
      
      return count;
    }
  
    var branches = 1;
    for (var i = 0; i < self.inputs.length; i++) {
      branches *= countBranches(self.inputs[i], 0, i == 0 ? 0 : self.inputs[i - 1][self.inputs[i - 1].length - 1]);
    }
    console.log(branches);
  });
}

var solutions = {
  '10': {
    '2': aoc10_2
  }
}

solutions[day][exercise]();
