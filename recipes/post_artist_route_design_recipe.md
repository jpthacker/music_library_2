# POST /albums Route Design Recipe

## 1. The Route Signature

  * the HTTP method: POST
  * the path: /artists
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body): name={string}, genre={string}

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
POST /artists

# With body parameters:
name=Wild Nothing
genre=Indie

# Expected response (200 OK)
(No content)

# Then subsequent request:
GET /artists

# Expected response (200 OK)
Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild Nothing
```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

    context "POST /artists" do
        it "adds an artist to the database" do
            response = post('/artists', :name => 'Wild Nothing', :genre => 'Indie')
            expect(response.status).to eq 200
            expect(response.body).to eq ''

            response = get('/artists')
            expect(response.body).to include('Wild Nothing')
        end
    end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.