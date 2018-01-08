require "pry"
require 'nokogiri'
require 'open-uri'

class BestBooks::Scraper

  def self.make_books
    #go to amazon chart
    doc = Nokogiri::HTML(open("https://www.amazon.com/charts"))

    #extract the properties, iterate through, and instantiate
    doc.css(".kc-vertical-rank-container").each do |book|
      title=book.css(".kc-rank-card-title").text.lstrip.gsub(/[\n]/,"").rstrip  #need to see if white sprace at end is an issue
      author=book.css(".kc-rank-card-author").text.gsub(/[\n by]/,"")
      reviews=book.css(".numeric-star-data small").text
      weeks_on_list=book.css(".kc-wol").text
      summary=book.css(".kc-vertical-rank-container p").text
      profile_url=book.css(".icons .see-in-store").attribute("href").value

      BestBooks::Book.new(title, author, reviews, weeks_on_list, summary, profile_url)
      end
    end

end
