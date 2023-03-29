require "spec_helper"
require "rack/test"
require_relative "../../app"

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  context "GET /" do
    it "returns a HTML site menu" do
      response = get('/')
      expect(response.status).to eq 200
      expect(response.body).to include('<body>')
      expect(response.body).to include('<h1>Music Library</h1>')
      expect(response.body).to include('<div>')
      expect(response.body).to include('<a href="/albums">Albums</a>')
      expect(response.body).to include('<a href="/albums/new">Add Album</a>')
      expect(response.body).to include('<a href="/artists">Artists</a>')
      expect(response.body).to include('<a href="/artists/new">Add Artist</a>')
    end
  end

  context "GET /albums" do
    it "returns all the albums in a database" do
      response = get("/albums")
      expect(response.status).to eq 200
      expect(response.body).to include('<body>')
      expect(response.body).to include('Waterloo')
      expect(response.body).to include('Baltimore')
      expect(response.body).to include('<a href="albums/3">')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
    end
  end

  context "GET /albums/new" do
    it "returns a form to create a new album" do
      response = get('/albums/new')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Create a new album</h1>')
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('<label for="title">Enter a title</label>')
      expect(response.body).to include('<input id="title" type="text" name="title">')
      expect(response.body).to include('<label for="release_year">Enter a release year</label>')
      expect(response.body).to include('<input id="release_year" type="text" name="release_year">')
      expect(response.body).to include('<label for="artist_id">Enter an artist id</label>')
      expect(response.body).to include('<input id="artist_id" type="text" name="artist_id">')
      expect(response.body).to include('<input type="submit" value="Create album">')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
    end
  end

  context "GET /albums/:id" do
    it "returns an album from database by id" do
      response = get("/albums/3")
      expect(response.status).to eq 200
      expect(response.body).to include('<body>')
      expect(response.body).to include('<h1>Waterloo</h1>')
      expect(response.body).to include('1974')
      expect(response.body).to include('ABBA')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
    end
  end

  context "POST /albums" do
    it "adds an album to the database" do
      response = post("/albums", title: "Voyager", release_year: 2002, artist_id: 2)
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Album created</h1>')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
      response = get("/albums")
      expect(response.body).to include("Voyager")
    end
  end

  context "GET /artists" do
    it "returns all the artists in a database" do
      response = get("/artists")
      expect(response.status).to eq 200
      expect(response.body).to include('<body>')
      expect(response.body).to include('<div>')
      expect(response.body).to include('<a href="artists/1">Pixies</a>')
      expect(response.body).to include('<a href="artists/2">ABBA</a>')
      expect(response.body).to include('<a href="artists/5">Kiasmos</a>')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
    end
  end

  context "GET /artists/new" do
    it "returns a form to create a new artist" do
      response = get('/artists/new')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Create a new artist</h1>')
      expect(response.body).to include('<form method="POST" action="/artists">')
      expect(response.body).to include('<label for="name">Enter a name</label>')
      expect(response.body).to include('<input id="name" type="text" name="name">')
      expect(response.body).to include('<label for="genre">Enter a genre</label>')
      expect(response.body).to include('<input id="genre" type="text" name="genre">')
      expect(response.body).to include('<input type="submit" value="Create artist">')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
    end
  end

  context "GET /artists/:id" do
    it "returns the correct HTML" do
      response = get("/artists/3")
      expect(response.status).to eq 200
      expect(response.body).to include('<body>')
      expect(response.body).to include('<h1>Taylor Swift</h1>')
      expect(response.body).to include('<p>Genre: Pop</p>')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
    end
  end

  context "POST /artists" do
    it "adds an artist to the database" do
      response = post("/artists", name: "Wild Nothing", genre: "Indie")
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Artist created</h1>')
      expect(response.body).to include('</br></br><a href="/">Home</a>')
      response = get("/artists")
      expect(response.body).to include("Wild Nothing")
    end
  end
end
