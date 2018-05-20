require 'rubygems'
require 'httparty'

# Note : add the httparty to your local machine.
# gem install httparty
#
# Example : API url's
# jsonplaceholder.typicode.com/,reqres.in/....etc
#
# Usage: ruby moreapiconnect.rb

class MoreApiConnect
  include HTTParty
  base_uri 'reqres.in/'

  def connects
    self.class.get('/api/users/2')
  end
end
api = MoreApiConnect.new
puts api.connects
