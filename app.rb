# file: app.rb
require "sinatra"
require "sinatra/reloader"
require_relative "lib/database_connection"
require_relative "lib/album_repository"
require_relative "lib/artist_repository"
require_relative "lib/album"
require_relative "lib/artist"
require "erb"

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "lib/album_repository"
    also_reload "lib/artist_repository"
  end

  get "/" do
    return erb(:index)
  end

  get "/albums" do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:albums)
  end

  get "/albums/new" do
    return erb(:new_album)
  end

  get "/albums/:id" do
    album_id = params[:id]
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = album_repo.find(album_id)
    @artist = artist_repo.find(@album.artist_id)
    return erb(:album)
  end

  post "/albums" do
    if invalid_album_request_parameters?
      # Set the response code
      # to 400 (Bad Request) - indicating
      # to the client it sent incorrect data
      # in the request.
      status 400
      return ''
    end
    album = Album.new
    album.title = ERB::Util.html_escape(params[:title])
    album.release_year = ERB::Util.html_escape(params[:release_year])
    album.artist_id = ERB::Util.html_escape(params[:artist_id])
    repo = AlbumRepository.new
    repo.create(album)
    return erb(:post_album)
  end

  get "/artists" do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:artists)
  end

  get "/artists/new" do
    return erb(:new_artist)
  end

  get "/artists/:id" do
    artist_id = params[:id]
    repo = ArtistRepository.new
    @artist = repo.find(artist_id)
    return erb(:artist)
  end

  post "/artists" do
    if invalid_artist_request_parameters?
      # Set the response code
      # to 400 (Bad Request) - indicating
      # to the client it sent incorrect data
      # in the request.
      status 400
      return ''
    end
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]
    repo = ArtistRepository.new
    repo.create(artist)
    return erb(:post_artist)
  end

  def invalid_album_request_parameters?
    # Are the params nil?
    return true if params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
  
    # Are they empty strings?
    return true if params[:title] == "" || params[:release_year] == "" || params[:artist_id] == ""
  
    return false
  end

  def invalid_artist_request_parameters?
    # Are the params nil?
    return true if params[:name] == nil || params[:genre] == nil
  
    # Are they empty strings?
    return true if params[:name] == "" || params[:genre] == ""
  
    return false
  end
end
