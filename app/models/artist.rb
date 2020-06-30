class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, :through => :songs

  #seems like slug and find_by_slug methods could be broken into a module?
  def slug
    #it strips out special characters, and replaces all spaces with -
    name.split.join("-").downcase
  end

  def self.find_by_slug(slug)
    no_cap = ["a", "with"]

    #slug = slug.split("-").join(" ").titlecase
    slug = slug.split("-").join(" ")
    deslug = slug.split(" ").map { |word|
      if no_cap.include?(word)
        word
      else
        word.capitalize
      end
    }.join(" ")
    artist = Artist.find_by(name: deslug)
    artist
  end
end
