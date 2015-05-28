var five = require("johnny-five");
var board = new five.Board();

// the board's pins will not be accessible until
// the board has reported that it is ready

board.on("ready", function() {
	console.log("Ready!");
	//var led = new five.Led(12);

	var red = new five.Led(12);
	var green = new five.Led(3);

	/*this.repl.inject({
    // Allow limited on/off control access to the
    // Led instance from the REPL.
    on: function() {
      led.on();
    },
    off: function() {
      led.off();
    }
  });

	*/

	//var startTime = 1000;

	/*function countdown(time) {
		if (startTime > 100) {
			startTime -= 10;	
		} else {
			startTime += 10;
		}
	}*/

	setInterval(function() {

	}, 500);

	//led.blink(1000);

	red.blink(1000);
	green.pulse({
	  easing: "linear",
	  duration: 3000,
	  cuePoints: [0, 0.2, 0.4, 0.6, 0.8, 1],
	  keyFrames: [0, 10, 0, 50, 0, 255],
	  onstop: function() {
	    console.log("Animation stopped");
	  }
	});
})