my_tickets_file = "my_tickets.txt"
rand_tickets_file = "rand_tickets.txt"

my_tickets = []
rand_tickets = []

File.open(my_tickets_file, "r") do |f|
  	f.each_line do |line|
  		numbers = line.split(" ")
  		powerball = numbers.pop #remove powerball

  		numbers.map! do |n|
  			n.strip.to_i
  		end 

  		numbers.sort!

  		numbers << powerball.to_i
  	
  		my_tickets << numbers
  	end
 end


File.open(rand_tickets_file, "r") do |f|
  	f.each_line do |line|
  		numbers = line.split(" ")
  		powerball = numbers.pop #remove powerball

  		numbers.map! do |n|
  			n.strip.to_i
  		end 

  		numbers.sort!

  		numbers << powerball.to_i
  	
  		rand_tickets << numbers
  	end
end




def make_winning_comb
	combination = []

	combination << rand(1..69)

	4.times do 
		n= rand(1..69)
		until !combination.include?(n)
			n = rand(1..69)
		end

		combination << n
	end 

	combination.sort!

	combination << rand(1..26)

	combination
end 

combination = make_winning_comb

my_count = 1

until my_tickets.include?(combination)
	if (my_count%1000000 == 0)
		print my_count
		print "\n"
	end
	my_count += 1
	combination = make_winning_comb
end
print "MINE: #{my_count} \n"
print "winning ticket: #{combination}\n"

rand_count = 0

until rand_tickets.include?(combination)
	if (rand_count%1000000 == 0)
		print rand_count
		print "\n"
	end
	rand_count += 1
	combination = make_winning_comb
end

print "RANDOM: #{rand_count} \n"
print "winning ticket: #{combination}\n"







