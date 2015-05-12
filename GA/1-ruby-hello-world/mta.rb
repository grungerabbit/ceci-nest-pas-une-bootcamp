
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
	'broadway' => [ '59thLex', '5th59th', '57th7th', '49thBway', '42ndTSQ', '34thHSQ', '28thBway', '23rdBway', '14thUSQ' ],
	'lex' => [ '68thLex', '59thLex', '51stLex', '42ndGCT', '33rdLex', '23rdLex', '14thUSQ' ]
}

def getSubway(startStop, endStop)
	# return $subway

	# puts "running"
	tracker = {}

	$subway.each do |key, value|
		#puts "#{key} equals #{value}"

		#puts key
		#puts value
		#puts startStop



		# puts value.include?(startStop)

		if value.include?(startStop)
			# puts value.index(startStop)

			tracker['startIndex'] = value.index(startStop)
			tracker['startLine'] = key
		end

		if value.include?(endStop)
			# puts value.index(endStop)

			tracker['endIndex'] = value.index(endStop)
			tracker['endLine'] = key
		end

		# puts value[startStop]

		#value.each do |stop|
		#	puts stop
		#end

		#if startStop == value 
		#	puts "hello"
		#end
	end

	puts tracker

	def findBestTransfer(lineOne, lineTwo, stopOne, stopTwo)
		# puts "!!!"

		# puts "sprinting"
		#puts $subway[lineOne]
		#puts $subway[lineTwo]
		#puts $subway[lineOne].length
		#puts $subway[lineTwo].length



		#shorter = $subway[lineOne].length <= $subway[lineTwo].length ? $subway[lineOne] : $subway[lineTwo]
		#longer = shorter == $subway[lineOne] ? $subway[lineTwo] : $subway[lineOne]
		#shorterLength = shorter.length
		#longerLength = longer.length

		one = $subway[lineOne]
		two = $subway[lineTwo]

		#puts shorter
		#puts "!"
		#puts longer


		tripLengths = []
		possibilities = []

		

		one.each_with_index do |station, idx|
			#puts longer.include?(station)

			if two.include?(station)
				#possibilities.push()

				possibilities.push({ 'lineTwoTransfer' => two.index(station), 'lineOneTransfer' => idx, 'station' => station })


				#puts longer.index(station)
				#puts idx
				# puts stopOne
				# puts stopTwo
				
				# puts "!!"
			end
		end

		# puts possibilities
		#puts shorterLength
		#puts longerLength

		#puts one.length
		#puts two.length

		#puts stopOne
		#puts stopTwo

		#puts lineOne
		#puts lineTwo

		oneAdj = one.length - 1
		twoAdj = two.length - 1


		# here we will need to check how many stopOne is away from either the beginning or the end
		
		# stopOne is 2, stopTwo is 5
		# lineOne is at index 0 and is 9 long
		# lineTwo is at index 1 and is 7 long
		# lineOne is at index 6 and is 9 long
		# lineTwo is at index 8 and is 7 long


		# stopOne - lineOne = 2 - 0 = 2
		# lineTwo - stopTwo = 7 - 5 = 2

		#puts "#{stopOne} - #{lineOne}"


		#puts possibilities


		possibilities.each_with_index do |set, idx|

			#puts possibilities.length

			#puts set["lineOneTransfer"]
			#puts set["lineTwoTransfer"]

			#puts set["lineOneTransfer"]
			#puts stopOne

			#puts "hello"
			
			#puts (stopOne > set["lineOneTransfer"] ? stopOne - set["lineOneTransfer"] : oneAdj - stopOne)
			#puts (stopTwo > set["lineTwoTransfer"] ? stopTwo - set["lineTwoTransfer"] : twoAdj - stopTwo)

			# this will work only in a limited case, it is brittle


			distanceOne = stopOne > set["lineOneTransfer"] ? stopOne - set["lineOneTransfer"] : oneAdj - stopOne
			distanceTwo = stopTwo > set["lineTwoTransfer"] ? stopTwo - set["lineTwoTransfer"] : twoAdj - stopTwo

			#puts distanceOne + distanceTwo

			combined = distanceOne + distanceTwo

			#puts combined

			tripLengths << combined

			#puts idx
			#puts combined

			tripLengths[idx] = combined
			

		end

		# what the eff
		return tripLengths.join(", ")

	#	puts tripLengths
	end


	if tracker['startLine'] == tracker['endLine']
		return tracker['endIndex'] - tracker['startIndex']
	else
		testTransfer = findBestTransfer(tracker['startLine'], tracker['endLine'], tracker['startIndex'], tracker['endIndex'])
		zeroth = testTransfer.split(", ")[0].to_i
		first = testTransfer.split(", ")[1].to_i

		# return the smaller
		return zeroth > first ? first : zeroth
	end

	# puts subway["broadway"][startStop]
	#subway.each{ |key, value| puts "#{key} equals #{value}" }
end

# puts getSubway('59thLex', '57th7th')

# subway["broadway"].each(puts this)

#def foo
#	return "foo"
#end

#puts foo

puts getSubway('49thBway','23rdBway')
puts getSubway('57th7th','23rdLex')
puts getSubway('28thBway','23rdLex')