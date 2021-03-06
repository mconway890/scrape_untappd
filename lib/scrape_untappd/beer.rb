class ScrapeUntappd::Beer
  attr_accessor :name, :style, :brewery, :abv, :description, :url

  def self.today
    self.scrape_beers
  end

  def self.scrape_beers
    beers = []
    beers << self.scrape
    beers
  end

  def self.scrape
    doc = Nokogiri::HTML(open("https://untappd.com/beer/top_rated"))

    doc.search("div.beer-details").collect do |section|
      beer = self.new
      beer.name = section.search("p.name a").text
      beer.style = section.search("p.style").text.slice(-52..-1)
      beer.brewery = section.search("p.style a").text
      beer
    end
  end

end
