Amount = 100000

raw_data = "data.txt"
gen_data = "gen_data.txt"



File.open(gen_data, "w") do |f| #easier vis
	Amount.times do 
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
