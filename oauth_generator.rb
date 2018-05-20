#!/usr/bin/env ruby
# Before you run this script the first time, you'll need to run
# gem install oauth clipboard docopt ffi

begin
  require 'oauth'
  require 'oauth/consumer'
  require 'oauth/signature/plaintext'
  require 'clipboard'
  require 'docopt'
rescue LoadError
  puts 'Please run `gem install oauth clipboard docopt ffi` first'
  exit
end

doc = <<DOCOPT
Oauth Header Generator
Usage:
#{__FILE__} (dev|staging|prod) [-n] [-o]
#{__FILE__} -h | --help
#{__FILE__} -v | --version
Options:
  -n --no-copy     Don't copy the header to the clipboard
  -o --output      Output the header to the screen
  -h --help        Show this message
  -v --version     Show the version
DOCOPT

begin
  options = Docopt::docopt(doc, version: '1.0')
rescue Docopt::Exit => e
  puts e.message
  exit
end

environment = ''
%w(dev staging prod).each { |env| environment = env if options[env] }
environment_details = {
  'dev' => {
    # key: 'f67215e3-2c44-4519-9b19-e2794a92e947',
    # secret: 'rVlIi8rO3WQCO9raCWsC-tSvOTjk2KY_',
    key: '39f3b8b6-0e6b-4de6-b378-c2e6ff9f04dc',
    secret: 'xRQhR-OgbpN1HmDm8Al8T26DRUmchvkH',
    url: 'https://api.endpoint.com/oauth/access',
  },
  'staging' => {
    key: '8b928f36-866d-45bc-b69b-574304414f32',
    secret: 'w4bJyLzgqntKlfiT3nz5MKSJ1UhhO3-c',
    url: 'https://api.endpoint.com/oauth/access',
  },
  'prod' => {
    key: "9a8a32de-fd12-4f5e-8455-43067d04daa3", # FILL ME IN
    secret: "pByvIC_Yc4LfEAPmnmuliaJAN0SlUFGZ", # FILL ME IN
    url: 'https://api.endpoint.com/oauth/access',
  },
}

if environment_details[environment][:secret].nil?
  puts "You'll need to get the key and secret for #{environment} and add them to the environment details in this file."
  exit
end

consumer = OAuth::Consumer.new(
  environment_details[environment][:key],
  environment_details[environment][:secret],
  access_token_url: environment_details[environment][:url],
  signature_method: 'PLAINTEXT',
)

token = consumer.get_access_token(nil)

path = 'http://services.endpoint.net/storefront' # this doesn't actually matter, just needed for the request
request = consumer.create_signed_request(:get, path, token)

puts request['Authorization'] + "\n" if options['--output']
unless options['--no-copy']
  Clipboard.copy(request['Authorization'])
  puts "Authorization header for #{environment} copied to clipboard"
end
