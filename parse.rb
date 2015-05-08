require "open-uri"
require "nokogiri"

def parse link
	doc = Nokogiri::HTML(open(link))

	title = doc.css('title').text.to_s.scan(/[^|]*\s|\sTechCrunch$/)[0].strip

	doc = doc.xpath("//*[preceding::comment()[. = ' Begin: Wordpress Article Content ']]
	              [following::comment()[. = ' End: Wordpress Article Content ']]").xpath('//p')[0...-1].text

	return title, doc
end

data = []

url = 'http://techcrunch.com/page/1/'
doc = Nokogiri::HTML(open(url)).to_s

links = doc.scan(/http:\/\/techcrunch.com\/\d{4}\/\d{2}\/\d{2}\/[-\da-z]*\//).uniq


links.each do |link|
	title, text = parse link
	data << {title: title, text: text}
end


puts data