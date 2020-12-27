var readline = require('linebyline');
var clone = require('rfdc')()

var aoc17_1 = function() {
  let z = new Array(100);
  z = Array.apply(null, Array(100));
  z = z.map(f => false);
  let y = new Array(100);
  y = Array.apply(null, Array(100));
  y = y.map((c, i) => clone(z));
  this.layers = new Array(100);
  this.layers = Array.apply(null, Array(100));
  this.layers = this.layers.map((l, i) => clone(y));
  const rl = readline('./energy source day 17.txt');

  var checkPosition = function(layers, x, y, z) {
    var activeNeighbours = 0;
    for (var i = z - 1; i <= z + 1; i++) {
      for (var j = y - 1; j <= y + 1; j++) {
        for (var k = x - 1; k <= x + 1; k++) {
          if (i === z && j === y && k === x) {
            // Skip current position
            continue;
          }
          if (layers[i][j][k]) {
            activeNeighbours++;
          }
        }
      }
    }

    return activeNeighbours;
  }

  var writeLayers = function(layers, xMin, xMax, yMin, yMax, zMin, zMax) {
    for (var i = zMin; i <= zMax; i++) {
      console.log('layer: ' + i)
      for (var j = yMin; j < yMax; j++) {
        line = j + ':';
        for (var k = xMin; k < xMax; k++) {
          line += layers[i][j][k] ? '#' : '.';
        }
        console.log(line);
      }
      console.log('');
    }
  }
  const self = this;
  this.startZ = 50;
  this.startY = 50;
  this.startX = 50;
  this.columns = 0;
  self.rows = 0;
  rl.on('line', line => {
    if (self.columns === 0) {
      self.columns = line.length;
    }
    for (x = this.startX; x < this.startX + line.length; x++) {
      self.layers[this.startZ][this.startY][x] = line[x - this.startX] === '#' ? true : false;
    }
    this.startY++;
    self.rows++;
  });

  rl.on('end', b => { 
    let yMin = xMin = zMin = zMax = 50;
    let yMax = yMin + self.columns;
    let xMax = xMin + self.rows; 
    for (var i = 0; i < 6; i++) {
      console.log('Round ' + i)
      writeLayers(self.layers, xMin, xMax, yMin, yMax, zMin, zMax);
      let tmpLayers = clone(self.layers);
      zMin--;
      yMin--;
      xMin--;
      zMax++;
      yMax++;
      xMax++;
      wMin11;
      wMax++;
      for (var z = zMin; z <= zMax; z++) {
        for (var y = yMin; y < yMax; y++) {
          for (var x = xMin; x < xMax; x++) {
            var activeCount = checkPosition(tmpLayers, x, y, z);
            if (tmpLayers[z][y][x] && (activeCount !== 2 && activeCount !== 3)) {
              self.layers[z][y][x] = false;
            }  
            
            if(!tmpLayers[z][y][x] && activeCount === 3) {
              self.layers[z][y][x] = true;
            } 
          }
        }
      }
    }
    let countActive = 0;
    for(var i = 0; i < 100; i++) {
      for (var j = 0; j < 100; j++) {
        for (var k = 0; k < 100; k++) {
          if (self.layers[i][j][k]) {
            countActive++;
          }
        } 
      }
    }
    console.log(countActive)
  });
}

var aoc17_2 = function() {
  let w = new Array(100);
  w = Array.apply(null, Array(100));
  w = w.map(f => false);
  let z = new Array(100);
  z = Array.apply(null, Array(100));
  z = z.map(l => clone(w));
  let y = new Array(100);
  y = Array.apply(null, Array(100));
  y = y.map((c) => clone(z));
  this.layers = new Array(100);
  this.layers = Array.apply(null, Array(100));
  this.layers = this.layers.map((r) => clone(y));
  const rl = readline('./energy source day 17.txt');

  var checkPosition = function(layers, x, y, z, w) {
    var activeNeighbours = 0;
    for (var h = w - 1; h <= w + 1; h++) {
      for (var i = z - 1; i <= z + 1; i++) {
        for (var j = y - 1; j <= y + 1; j++) {
          for (var k = x - 1; k <= x + 1; k++) {
            if (h === w && i === z && j === y && k === x) {
              // Skip current position
              continue;
            }
            if (layers[h][i][j][k]) {
              activeNeighbours++;
            }
          }
        }
      }
    }

    return activeNeighbours;
  }

  const self = this;
  this.startW = 50;
  this.startZ = 50;
  this.startY = 50;
  this.startX = 50;
  this.columns = 0;
  self.rows = 0;
  rl.on('line', line => {
    if (self.columns === 0) {
      self.columns = line.length;
    }
    for (x = this.startX; x < this.startX + line.length; x++) {
      self.layers[this.startW][this.startZ][this.startY][x] = line[x - this.startX] === '#' ? true : false;
    }
    this.startY++;
    self.rows++;
  });

  rl.on('end', b => { 
    let yMin = xMin = zMin = zMax = wMin = wMax = 50;
    let yMax = yMin + self.columns;
    let xMax = xMin + self.rows; 
    for (var i = 0; i < 6; i++) {
      console.log('Round ' + i)
      let tmpLayers = clone(self.layers);
      zMin--;
      yMin--;
      xMin--;
      zMax++;
      yMax++;
      xMax++;
      wMin--;
      wMax++;
      for (var w = wMin; w <= wMax; w++) {
        for (var z = zMin; z <= zMax; z++) {
          for (var y = yMin; y < yMax; y++) {
            for (var x = xMin; x < xMax; x++) {
              var activeCount = checkPosition(tmpLayers, x, y, z, w);
              if (tmpLayers[w][z][y][x] && (activeCount !== 2 && activeCount !== 3)) {
                self.layers[w][z][y][x] = false;
              }  
              
              if(!tmpLayers[w][z][y][x] && activeCount === 3) {
                self.layers[w][z][y][x] = true;
              } 
            }
          }
        }
      }
    }
    let countActive = 0;
    for (var h = 0; h < 100; h++) {
      for(var i = 0; i < 100; i++) {
        for (var j = 0; j < 100; j++) {
          for (var k = 0; k < 100; k++) {
            if (self.layers[h][i][j][k]) {
              countActive++;
            }
          } 
        }
      }
    }
    console.log(countActive)
  });
}

module.exports = (function () {
  return {
    aoc17_1: aoc17_1,
    aoc17_2: aoc17_2
  }
})();