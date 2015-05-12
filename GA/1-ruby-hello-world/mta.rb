
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
	'lex' => [ '68thLex', '59thLex', '51stLex', '42ndGCT', '33rdLex', '28thLex', '23rdLex', '14thUSQ' ],
	'fourteenth' => ['14th8th', '14th7th', '14th6th', '14thUSQ', '14th3rd', '14th1st', 'bedford'],
	'seventh' => ['66thLC', '59thCC', '50th7th', '42ndTSQ', '34thPS', '28th7th', '23rd7th', '18th7th', '14th7th', 'christopher'],
	'eighth' => ['59thCC', '50th8th', '42ndPA', '34thPS', '23rd8th', '14th8th', 'w4th']
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

	return "bad input" if tracker.length != 4 # quit if we couldn't find station matches

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
		shortest_route = 1000

		possibilities.each do |set|
			# examine if this is brittle
			distanceOne = stopOne > set["lineOneTransfer"] ? stopOne - set["lineOneTransfer"] : set["lineOneTransfer"] - stopOne
			distanceTwo = stopTwo > set["lineTwoTransfer"] ? stopTwo - set["lineTwoTransfer"] : set["lineTwoTransfer"] - stopTwo

			combined = distanceOne + distanceTwo
			shortest_route = combined if combined < shortest_route
		end
		return shortest_route
	end

	# returning answers
	if tracker['startLine'] == tracker['endLine']
		return (tracker['endIndex'] - tracker['startIndex']).abs
	else
		return findBestTransfer(tracker['startLine'], tracker['endLine'], tracker['startIndex'], tracker['endIndex'])
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
		puts "known issues: 2+ transfers"
	end	
end


generateAnswers('49thBway','23rdBway', 4, false)
generateAnswers('23rdBway','49thBway', 4, false)
generateAnswers("bad", "14th8th", "bad input", false)
generateAnswers('57th7th','23rdLex', 7, 7)
generateAnswers('28thBway','23rdLex', 3, 11)
generateAnswers('14th8th', '14th1st', 5, false)
generateAnswers('68thLex', 'bedford', 10, false)
generateAnswers('59thCC', '14th6th', 7, false)
generateAnswers('59thCC', '42ndGCT', 12, "2+ transfers")
generateAnswers('68thLex', '23rdBway', 8, 8)
generateAnswers('68thLex', '34thHSQ', 6, 10)
generateAnswers('50th8th', 'bedford', 10, false)
generateAnswers('50th7th', '14th8th', 4, 6)