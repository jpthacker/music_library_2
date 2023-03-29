# POST /albums Route Design Recipe

## 1. The Route Signature

  * the HTTP method: POST
  * the path: /albums
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body): title=[string], release_year=[year], artist_id=[int]

## 2. The Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```
# Expected response (200 OK)
(No content)
```

## 3. Examples

_Replace these with your own design._

```
# Request:
POST /albums

# With body parameters:
title=Voyage
release_year=2022
artist_id=2

# Expected response (200 OK)
(No content)

# Request:
GET /albums

# Expected response (200 OK)
List of albums
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "Post /albums" do
    it 'returns the correct response status' do
      response = post('/albums', title: 'voyage', release_year: 2002, artist_id: 2)

      expect(response.status).to eq(200)
    end

    it 'posts an album to the database' do
        post('/albums', title: 'voyage', release_year: 2002, artist_id: 2)
        response = get('/albums')
        expect(response.size).to eq 13
        expect(response.last.title).to eq 'voyage'
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.