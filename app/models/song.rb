class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    #it strips out special characters, and replaces all spaces with -
    name.split.join("-").downcase
  end

  def self.find_by_slug(slug)
    no_cap = ["the", "with"]

    #slug = slug.split("-").join(" ").titlecase
    slug = slug.split("-").join(" ")
    deslug = slug.split(" ").map { |word|
      if no_cap.include?(word)
        word
      else
        word.capitalize
      end
    }.join(" ")
    song = Song.find_by(name: deslug)
    song
  end

end
