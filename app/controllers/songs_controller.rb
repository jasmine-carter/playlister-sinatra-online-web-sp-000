require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    #shows the page to create a new song
    erb :'/songs/new'
  end

  post '/songs' do
    #creates a new song and redirects to song/:slug
    @song = Song.create(params[:song])
    #binding.pry
    if !params["artist"].empty?
      @song.artist = Artist.find_or_create_by(name: params["artist"]["name"])
      end
    @song.genre_ids = params[:genres]
    @song.save
    flash[:message]  = "Successfully created song."
    redirect to ("/songs/#{@song.slug}")
  end

  #show specific song page
  get '/songs/:slug' do
    #binding.pry
    @song = Song.find_by_slug(params[:slug])
    #binding.pry
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    #binding.pry
    erb :'/songs/edit'
  end

  post '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    if !params[:song].keys.include?
    end
    redirect to ("/songs/#{@song.slug}")
  end

  patch '/songs/:slug' do
    #binding.pry
    #{}"you made it to the patch path!"
    @song = Song.find_by_slug(params[:slug])
    @artist = Artist.find_or_create_by(name: params["artist"]["name"])
    #binding.pry
    @song.update(artist: @artist)
    @song.genre_ids = params[:genres]
    #needs to find or create an artist based on params
    flash[:message] = "Successfully updated song."
    redirect "/songs/#{@song.slug}"
  end


end
