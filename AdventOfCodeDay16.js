var readline = require('linebyline');

var aoc16_1 = function() {
  const rl = readline('./flight tickets day 16.txt');
  var tickets = [];
  var rules = {};
  var phase = 'rules';
  var myTicket;
  rl.on('line' , line => {
    var ruleRegex = new RegExp(/^([a-z| ]+): (\d+)-(\d+) or (\d+)-(\d+)/);
    var myTicketRegex = new RegExp(/your ticket:/);
    var ticketsRegex = new RegExp(/nearby tickets:/);
    if (ruleRegex.test(line)) {
      var matches = ruleRegex.exec(line);
      var intervals = []
      intervals.push([parseInt(matches[2]), parseInt(matches[3])]);
      intervals.push([parseInt(matches[4]), parseInt(matches[5])]);
      rules[matches[1]] = intervals;
     } else if (myTicketRegex.test(line)) {
       phase = 'my';
     } else if (ticketsRegex.test(line)) {
       phase = 'nearby';
     } else {
       if (line !== '') {
         if (phase === 'my') {
           myTicket = line.split(',').map(t => parseInt(t));
         } else {
          tickets.push(line.split(',').map(t => parseInt(t))); 
         }
       }
     }

  });
  rl.on('end', () => {
    var invalidTickets = [];
    var isValid = function(ticketId) {
      for(rule in rules) {
        for (var i = 0; i < rules[rule].length; i++) {
          if (ticketId >= rules[rule][i][0] && ticketId <= rules[rule][i][1]) {
            return true;
          }
        }
      }
      return false;
    }

    for (var ticket of tickets) {
      for (value of ticket) {
        if (!isValid(value)) {
          invalidTickets.push(value);
        }
      }
    }

    var sum = invalidTickets.reduce((prev, curr) => curr + prev, 0);
    console.log(sum);
  });

}


var aoc16_2 = function() {
  const rl = readline('./flight tickets day 16.txt');
  var tickets = [];
  var rules = {};
  var phase = 'rules';
  var myTicket;
  rl.on('line' , line => {
    var ruleRegex = new RegExp(/^([a-z| ]+): (\d+)-(\d+) or (\d+)-(\d+)/);
    var myTicketRegex = new RegExp(/your ticket:/);
    var ticketsRegex = new RegExp(/nearby tickets:/);
    if (ruleRegex.test(line)) {
      var matches = ruleRegex.exec(line);
      var intervals = []
      intervals.push([parseInt(matches[2]), parseInt(matches[3])]);
      intervals.push([parseInt(matches[4]), parseInt(matches[5])]);
      rules[matches[1]] = intervals;
     } else if (myTicketRegex.test(line)) {
       phase = 'my';
     } else if (ticketsRegex.test(line)) {
       phase = 'nearby';
     } else {
       if (line !== '') {
         if (phase === 'my') {
           myTicket = line.split(',').map(t => parseInt(t));
         } else {
          tickets.push(line.split(',').map(t => parseInt(t))); 
         }
       }
     }

  });
  rl.on('end', () => {
    var invalidTickets = [];
    var isValid = function(ticketId) {
      for(rule in rules) {
        for (var i = 0; i < rules[rule].length; i++) {
          if (ticketId >= rules[rule][i][0] && ticketId <= rules[rule][i][1]) {
            return true;
          }
        }
      }
      return false;
    }

    var matchesRule = function(ticketId, ruleName) {
      var rule = rules[ruleName];
      for (var i = 0; i < rule.length; i++) {
        if (ticketId >= rule[i][0] && ticketId <= rule[i][1])
          return true;
      }

      return false;
    }

    var validTickets = []
    for (var ticket of tickets) {
      var valid = true
      for (value of ticket) {
        if (!isValid(value)) {
          valid = false;
          break;
        }
      }

      if (valid) {
        validTickets.push(ticket);
      }
    }

    var positions = {}
    var matchedRules = []
    while (matchedRules.length < Object.keys(rules).length) {
      for (rule in rules) {
        if (matchedRules.find(r => r.rule === rule) !== undefined) {
          continue;
        }
        positions[rule] = [];
        for (var i = 0; i < Object.keys(rules).length; i++) {
          if (matchedRules.find(r => r.column === i) !== undefined) {
            continue;
          }
          var valid = true;
          for (var ticket of validTickets) {
            if (!matchesRule(ticket[i], rule)) {
              valid = false;
              continue;
            }
          }
          if (valid) {
            positions[rule].push(i);
          }
        }
        if (positions[rule].length === 1) {
          matchedRules.push({rule: rule, column: positions[rule][0] });
        }
      }
    }

    var neededPositions = [];
    for (position in positions) {
      var departureRegex = new RegExp(/^departure.*/);
      if (departureRegex.test(position)) {
        neededPositions.push(positions[position]);
      }
    }
    var product = neededPositions.reduce((prev, curr) => prev * myTicket[curr[0]], 1);
    console.log(product);
  });

}

module.exports = (function() {
  return { 
    aoc16_1: aoc16_1,
    aoc16_2: aoc16_2
  }
})();