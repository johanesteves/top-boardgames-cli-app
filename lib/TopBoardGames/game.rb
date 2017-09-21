class TopBoardGames::Game
  attr_accessor :title, :rank, :url, :avg_rating, :description, :game_id, :weight, :min_playtime, :max_playtime, :min_age
  @@all = []


  def self.game
    
  end

  def self.new_from_main_page(game_row)
    title = game_row.css(".collection_objectname a").text
    url = game_row.css(".collection_objectname a").attr("href").text
    avg_rating = game_row.css(".collection_bggrating")[1].text.strip
    game_id = url[/(\/\d*\/)/].gsub("/", "")
    rank = game_row.css(".collection_rank").text.strip

    self.new(title, rank, url, avg_rating, game_id)

  end


  def initialize(title = nil, rank = nil, url = nil, avg_rating = nil, game_id=nil)
    @title = title
    @rank = rank
    @url = url
    @avg_rating = avg_rating
    @game_id = game_id
    @@all << self
  end

  def self.all
    @@all
  end

  def description
    description_url = Nokogiri::HTML(open("https://boardgamegeek.com#{self.url}")).at("meta[name='description']")['content'].split("\n")
    @description ||= (description_url[0] + " " +description_url[2])
  end

  def stats_url
    Nokogiri::HTML(open("https://www.boardgamegeek.com/xmlapi2/thing?id=#{self.game_id}"))
  end
  
end