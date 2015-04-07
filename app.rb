require "bundler/setup"
require 'sinatra'
require 'rack-dynamic-reverse-proxy'
require 'redis'
require 'hirlite/connection'
require 'json'

redis = Redis.new(:host => ":memory:", :driver => Rlite::Connection::Hirlite)

use Rack::DynamicReverseProxy do
  reverse_proxy_options preserve_host: true

  reverse_proxy_rule do |env|
    if value = redis.get(env.host.split('.').first)
      value
    end
  end
end

get '/' do
  redis.incr 'counter'
  "test #{redis.get 'counter'}"
end

post '/' do
  params = JSON.parse request.body.read
  p params

  params.each{|key, value|
    redis[key] = value
  }
  params.to_json
end

delete '/:key' do
  p params[:key]
  redis.del params[:key]
  params[:key]
end
