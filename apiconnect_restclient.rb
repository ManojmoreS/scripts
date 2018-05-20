require 'rubygems'
require 'rest_client'
require 'digest/md5'
require 'json'
# require 'will_paginate/array'

class MoreApiConnect
  def initialize
    @public_key = 'XXXXXXX'
    @private_key = 'XXXXXXX'
    @base_url = 'http://testing.tesing.com'
  end

  def get_char_info(resource)
    params = authentication
    url_params = { resource: resource, ts: params[:ts], apikey: params[:apikey], hash: params[:hash] }
    response = RestClient.get(restruction_url(url_params))
    char_data = JSON.parse(response)['data']['results']
  end

  def authentication
    timestamp = Time.now.to_i.to_s
    oauth_hash = Digest::MD5.hexdigest(timestamp+@private_key+@public_key)
    { ts: timestamp, apikey: @public_key, hash: oauth_hash }
  end

  def restruction_url(params)
    "#{@base_url}#{params[:resource]}?ts=#{params[:ts]}&apikey=#{params[:apikey]}&hash=#{params[:hash]}"
  end
end
api = MoreApiConnect.new
api.get_char_info('/v1/public/comics')
