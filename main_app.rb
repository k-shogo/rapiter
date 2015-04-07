require "bundler/setup"
require 'sinatra/base'
require 'rack-dynamic-reverse-proxy'
require 'redis'
require 'json'


class MainApp < Sinatra::Base
  redis = Redis.new

  use Rack::DynamicReverseProxy do
    reverse_proxy_options preserve_host: true

    reverse_proxy_rule do |env|
      if value = redis.get(env.host.split('.').first)
        value
      end
    end
  end

  get '/' do
    keys = redis.keys
    keys.map{|k| [k, redis.get k]}.to_h.to_json
  end

  post '/' do
    params = JSON.parse request.body.read

    params.each{|key, value|
      redis[key] = value
    }
    params.to_json
  end

  delete '/:key' do
    redis.del params[:key]
    params[:key]
  end
end
