require 'csv'

def read_data file
	serialized_data = File.read(file)
	data = Marshal::load serialized_data
end

data = read_data('data.txt')

CSV.open("file.csv", "wb") do |csv|
	data.each do |d|
		csv << [d[:title], d[:link], d[:text]]
	end
end