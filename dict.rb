def generate_dict data
	h = Hash.new(0)

	data.each {|article| article[:text].each {|word| h[word] += 1}}
	
	h
end

def read_data file
	serialized_data = File.read(file)
	data = Marshal::load serialized_data
end

data = read_data('data.txt')

dict = generate_dict(data)

# deleting words from dictionary presented only once
dict = dict.delete_if{|k, v| v == 1}

# leaving only words, without frequency
dict = dict.keys

serialized_data = Marshal::dump(dict)

f = File.open('dict.txt', 'wb')

f.puts serialized_data