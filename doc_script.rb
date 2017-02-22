require 'net/http'
require 'uri'
require 'json'
require 'base64'

uri = URI.parse("http://localhost:3000/documents")

enc_file = Base64.encode64(File.open("template.pdf", "rb").read)

doc = {
	"document" => {
	   "name" => "template",
     "file" => "data:application/pdf;base64, #{enc_file}"
	}
}.to_json

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.path)
request['Content-Type'] = 'application/json'
request['Accept'] = 'vnd.daetsiinf_printing.v1'
request['Authorization'] = 'B9HzEJnqRyspmnKHLHYX'
request.body = "#{doc}"
# Send the request
response = http.request(request)

puts response.body
