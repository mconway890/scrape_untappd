# Our CLI Controller
class ScrapeUntappd::CLI

  def call
    list_top_beers
    menu
    goodbye
  end

  def list_top_beers
    puts center("Welcome to Scrape Untappd")
    puts ""
    puts "  Today's Top Beers:"
    puts ""
    @beers = ScrapeUntappd::Beer.scrape
    @beers.each.with_index(1) do |beer, i|
      puts " #{i}. #{beer.name} "
    end
  end

  def menu
    current_year = Date.today.year
    input = nil
    while input != "exit"
      puts ""
      puts wrap("Enter the number of beer you'd like more info on, 'list' to see today's beers again or 'exit'. For the top beers of #{current_year} enter 'year': ")
      puts ""
      input = gets.strip.downcase


    if input.to_i > 0
      the_beer = @beers[input.to_i - 1]
        puts ""
        puts "#{input.to_i}. #{the_beer.name} - #{the_beer.brewery} - #{the_beer.abv}"
        puts ""
        puts wrap("#{the_beer.description}").split('—')
      elsif input == "list"
        list_top_beers
      elsif input != "exit"
        puts "Your entry is invalid."
      end
    end
  end

  def goodbye
    puts ""
    puts "Thanks for coming! Cheers!"
    puts ""
  end

  def center(string, c = "-")
    string = " #{string} " if string != ""
    until string.length >= 40
      string.prepend(c)
      string << (c)
    end
    string.prepend("\n")
  end

  def wrap(s, width=70)
	  s.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
	end

end
