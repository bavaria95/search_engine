def read_data file
	serialized_data = File.read(file)
	data = Marshal::load serialized_data
end

dict = read_data('dict.txt')

data = read_data('data.txt')

bag_of_words = []

data.each do |article| 
	vect = [0]*dict.length

	article[:text].each do |word|
		index = dict.index word
		vect[index] += 1 if index
	end
	bag_of_words << vect

end

serialized_data = Marshal::dump(bag_of_words)

f = File.open('bag_of_words.txt', 'wb')

f.puts serialized_data