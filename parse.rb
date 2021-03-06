require "open-uri"
require "nokogiri"
require 'csv'
require 'fast-stemmer'
require 'set'

def parse_stop_words file
	s = File.open(file).gets
	s = Set.new(s.split(', '))
end

def parse link, stop_words
	doc = Nokogiri::HTML(open(link))

	title = doc.css('title').text.to_s.scan(/[^|]*\s|\sTechCrunch$/)[0].strip

	doc = doc.xpath("//*[preceding::comment()[. = ' Begin: Wordpress Article Content ']]
	              [following::comment()[. = ' End: Wordpress Article Content ']]").xpath('//p')[0...-1].text

	doc.downcase!

	# delete endings
	doc = doc.gsub(/’d/, ' ').gsub(/’ve/, ' ').gsub(/’re/, ' ')\
	.gsub(/n’t/, ' ').gsub(/’ll/, ' ').gsub(/’s/, ' ')

	#delete non-words
	doc = doc.scan(/\w+-\w+-\w+|\w+-\w+|\w+’s|\w+/)

	# delete stop words
	doc = doc.delete_if{|x| stop_words.include?(x)}

	# stemming
	doc = doc.map{|word| Stemmer::stem_word(word)}

	return title, doc
end

stop_words = parse_stop_words 'stopwords.txt'

data = []

N = 1000

basic_url = 'http://techcrunch.com/page/'

(1..N).each do |i|
	url = basic_url + i.to_s

	doc = Nokogiri::HTML(open(url)).to_s

	links = doc.scan(/http:\/\/techcrunch.com\/\d{4}\/\d{2}\/\d{2}\/[-\da-z]*\//).uniq

	threads = []

	links.each do |link|
		threads << Thread.new do
			title, text = parse link, stop_words
			data << {title: title, text: text, link: link}
		end
	end

	threads.each do |thread|
	    thread.join
	end

	puts i

end

serialized_data = Marshal::dump(data)

f = File.open('data.txt', 'wb')

f.puts serialized_data