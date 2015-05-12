
"Step 1. 
Using Ruby basic data structures, such as Arrays & Strings, 
create a representation of the MTA subway system.
You do not know how to write your own Ruby classes." 

"Step 2. 
Write a Ruby function that, passed a start location 
& and end location, will return the number of stops
required to get from start station to end station."  

"Step 3. 
Write a command line program that, given a start station 
and an end station as an input. 
You can use the ARGV array and make your CL program UNIXy... 
http://jnoconor.github.io/blog/2013/10/13/a-short-explanation-of-argv/
or you can use Kernel#gets  
$ ri Kernel#gets 
making the program more interactive."

$subway = {
	'broadway' => [ 'queensboro', '59thLex', '5th59th', '57th7th', '49thBway', '42ndTSQ', '34thHSQ', '28thBway', '23rdBway', '14thUSQ', '8thBway' ],
	'lex' => [ '68thLex', '59thLex', '51stLex', '42ndGCT', '33rdLex', '23rdLex', '14thUSQ' ],
	'fourteenth' => ['14th8th', '14th6th', '14thUSQ', '14th3rd', '14th1st', 'bedford']
}

def getSubway(startStop, endStop)
	puts "-----------"
	tracker = {} # tracker for lines

	$subway.each do |key, value|
		# first check that the subway line has the stop
		# then get index of station and line name (for reference)
		if value.include?(startStop)
			tracker['startIndex'] = value.index(startStop)
			tracker['startLine'] = key
		end

		if value.include?(endStop)
			tracker['endIndex'] = value.index(endStop)
			tracker['endLine'] = key
		end
	end
	puts tracker

	return "bad input" if tracker.length != 4

	def findBestTransfer(lineOne, lineTwo, stopOne, stopTwo)
		one = $subway[lineOne]
		two = $subway[lineTwo]
		tripLengths = []
		possibilities = []
		
		# checking the first line against the second to see dupes
		# dupes = places where we can transfer
		one.each_with_index do |station, idx|
			if two.include?(station)
				possibilities.push({ 'lineTwoTransfer' => two.index(station), 'lineOneTransfer' => idx, 'station' => station })
			end
		end

		puts possibilities
		possibilities.each_with_index do |set, idx|
			# this will work only in a limited case, it is brittle
			distanceOne = stopOne > set["lineOneTransfer"] ? stopOne - set["lineOneTransfer"] : set["lineOneTransfer"] - stopOne
			distanceTwo = stopTwo > set["lineTwoTransfer"] ? stopTwo - set["lineTwoTransfer"] : set["lineTwoTransfer"] - stopTwo

			combined = distanceOne + distanceTwo

			# soooooo....
			# tripLengths << combined
			tripLengths[idx] = combined
		end
		# for some reason it doesn't return an array, so here is an absurd hack to force it
		return tripLengths.join(", ")
	end

	# returning answers
	if tracker['startLine'] == tracker['endLine']
		return (tracker['endIndex'] - tracker['startIndex']).abs
	else
		# in cases of multiple intersections
		# continuation of absurd hack - manually making the returned array
		testTransfer = findBestTransfer(tracker['startLine'], tracker['endLine'], tracker['startIndex'], tracker['endIndex'])
		return testTransfer unless testTransfer.match(/[,]/) # return if no comma and thus no mutiple intersections

		puts "options: #{testTransfer}"
		zeroth = testTransfer.split(", ")[0].to_i
		first = testTransfer.split(", ")[1].to_i

		# return the smaller route
		return zeroth > first ? first : zeroth
	end
end

def generateAnswers(startStop, endStop, expect, opt)
	submittedAnswer = getSubway(startStop, endStop)
	puts submittedAnswer
	puts "***"
	puts "human unit test: from #{startStop} to #{endStop}, expect #{expect}"
	puts "other option: #{opt}" if opt != false

	if expect == "bad input"
		puts "SUCCESSFUL FAIL!"
	elsif expect.to_i == submittedAnswer.to_i
		puts "PASSED!"
	else
		puts "FAILED"
		puts "known issues: stops beyond the transfer point"
	end	
end



generateAnswers('49thBway','23rdBway', 4, false)
generateAnswers('23rdBway','49thBway', 4, false)
generateAnswers("bad", "14th8th", "bad input", false)
generateAnswers('57th7th','23rdLex', 6, 7)
generateAnswers('28thBway','23rdLex', 3, 10)
generateAnswers('14th8th', '14th1st', 4, false)
generateAnswers('5th59th', '14th8th', 9, false)
generateAnswers('68thLex', 'bedford', 7, false)