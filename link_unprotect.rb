#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'erb'

require "base64"

set :views, lambda { File.join(root, "views") }
set :public, lambda { File.join(root, "public") }

get '/' do
  erb :index
end

post '/' do
  @link = case link = params[:link]
  when /^http/i then link
  when /#{'http'.reverse}$/i then link.reverse
  when /=$/ then Base64.decode64(link)
  else
    puts 'nenhum caso!'
  end
  erb :index
end