var five = require("johnny-five");
var board = new five.Board();

// the board's pins will not be accessible until
// the board has reported that it is ready

board.on("ready", function() {
	console.log("Ready!");
	//var led = new five.Led(12);

	var red = new five.Led(12);
	var green = new five.Led(3);

	function RNG(min, max) {
		return Math.floor(Math.random() * (max - min)) + min;
	}

	function rockPaperScissors(number) {
		console.log(number);
		red.off();
		green.off();

		if (number === 0) {
			red.on();
		} else if (number === 1) {
			green.on();
		} else {
			red.on();
			green.on();
		}
	}

	setInterval(function() {
		rockPaperScissors(RNG(0,3));
	}, 1000);

	red.on();
	green.on();
});