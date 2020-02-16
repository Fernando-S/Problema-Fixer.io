require 'rest-client'
require 'json'
require 'date'

# Logic for timestamp since Time-Series Endpoint isn't free in fixer.io
date = Date.new(2009, 8, 7)			# Starting date
end_date = Date.new(2011, 11, 18)	# Final date +1
ratesHash = {}


# Getting rates for EUR to BRL between 2009-08-07 and 2011-11-17 (YYYY-MM-DD format)
puts
puts "Listing all rates for EUR to BRL between 2009-08-07 and 2011-11-17 (YYYY-MM-DD format)..."
puts
puts "	Date				Rate"

until date === end_date do 
	# Getting info form fixer.io
	uri = "http://data.fixer.io/api/#{date}?access_key=935861fdb56554f4fe12138eb7e6f54e&base=EUR&symbols=BRL" 
	resp = RestClient.get uri
	rates = JSON.parse(resp)	# parsing api info to use it as a hash]

	ratesHash[date.to_s] = rates['rates']['BRL']
	puts "	#{date}		1 EUR -> #{ratesHash[date.to_s]} BRL"	
	date += 1		# Increment to posterior day


end
 

# Logic to find the average rate value excluding first and last days
ratesArray = ratesHash.values	# Creating an array with all rate values
minDay = ratesArray.min	# Setting min rate day
maxDay = ratesArray.max	# Setting max rate day

ratesArray.shift	# Get rid of first rate
ratesArray.pop		# Get rid of last rate
avg = ratesArray.sum / ratesArray.length	# Setting average rate 

puts
puts "Total days: #{ratesHash.length}"
puts "The lowest rate happened in: #{minDay}"
puts "The highest rate happened in: #{maxDay}"
puts "The average rate was (excluding first and last days): #{avg} BRL"
