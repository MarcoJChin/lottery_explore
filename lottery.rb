

require 'distribution'
data = Array.new

raw_data = "data.txt"
gen_data = "gen_data.txt"


File.open(raw_data, "r") do |f|
  f.each_line do |line|
  	numbers = line.split(" ")
  	powerball = numbers.pop #remove powerball

  	numbers.map! do |n|
  		n.strip.to_i
  	end 

  	numbers.sort!

  	numbers << powerball.to_i
  	
  	data << numbers
  end
end

File.open("data_sorted.txt", "w") do |f| #easier vis
	data.each do |n|
		n.each do |i|
			f.print "#{i}\t"
		end 
		f.print "\n"
	end 
end 

#done processing

tdata = data.transpose

#print tdata[0]

File.open("data_sorted_processed.txt", "w") do |f| #easier vis
	tdata.each do |n|
		n.each do |i|
			f.print "#{i} "
		end 
		f.print "\n"
	end 
end 


def make_histogram (st, en, data)

	freq = Hash.new

	(st..en).each do |n|
		freq[n] = 0
	end 
	
	

	data.each do |d|
	
		freq[d] += 1
	end 

	freq.each do |key, val|
		print "#{key}:\t"
		val.times do
			print "|"
		end 
		print "\n"
	end 
	puts
end 

def make_stat_summary (data)

	mean = 0
	data.each do |n|
		mean += n
	end 
	mean /= data.size

	sd = 0

	data.each do |n|
		sd += (n - mean)**2
	end 
	sd /= data.size

	sd = Math.sqrt(sd)

	print "mean: #{mean} \n"

	print "sd: #{sd.round(5)} \n"
=begin
	ran_num = -1
	until ran_num >= 1 && ran_num <= 69
		ran_num = (Distribution::Normal.rng mean, sd, nil).call.to_i
	end

	print "#{ran_num}\t"
=end

end 


def gen_num (data)

	mean = 0
	data.each do |n|
		mean += n
	end 
	mean /= data.size

	sd = 0

	data.each do |n|
		sd += (n - mean)**2
	end 
	sd /= data.size

	sd = Math.sqrt(sd)

	ran_num = -1
	until ran_num >= 1 && ran_num <= 69
		ran_num = (Distribution::Normal.rng mean, sd, nil).call.to_i
	end

	ran_num
end

def gen_tickets(amount, data)

	File.open("my_tickets.txt", "w") do |f| #easier vis
		amount.times do


			nums = []


			(0..4).each do |n|
				t = gen_num data[n]
				until !nums.include?(t)
					t = gen_num data[n]
				end

				nums << t
			end 

			nums.each do |n|
				f.print"#{n}\t"
			end 

			f.print "#{rand(1..26)}\n"

		end 
	end
end

def gen_random_tickets(amount)

	File.open("rand_tickets.txt", "w") do |f| #easier vis
		

		amount.times do 
			nums = []

			nums << rand(1..69)

			4.times do 
				n= rand(1..69)
				until !nums.include?(n)
					n = rand(1..69)
				end

				nums << n
			end 

			nums.each do |n|
				f.print"#{n}\t"
			end 

			f.print "#{rand(1..26)}\n"
	

		end 
	end
end
(0..4).each do |n|
	print "#{make_stat_summary tdata[n]}"

end 

gen_tickets 10, tdata
gen_random_tickets 10