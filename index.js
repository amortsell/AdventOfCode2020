var aoc10 = require('./AdventOfCodeDay10');
var aoc16 = require('./AdventOfCodeDay16');
var aoc17 = require('./AdventOfCodeDay17');
var aoc18 = require('./AdventOfCodeDay18');
const args = [ '18.2' ]; //process.argv.slice(2);
var day = args[0].split('.')[0];
var exercise = args[0].split('.')[1]

var solutions = {
  '10': {
    '2': aoc10.aoc10_2
  },
  '16': {
    '1': aoc16.aoc16_1,
    '2': aoc16.aoc16_2
  },
  '17': {
    '1': aoc17.aoc17_1,
    '2': aoc17.aoc17_2
  },
  '18': {
    '1': aoc18.aoc18_1,
    '2': aoc18.aoc18_2
  }
}

solutions[day][exercise]();
