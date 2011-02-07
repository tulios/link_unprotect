#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'erb'

require "base64"

set :views, lambda { File.join(root, "views") }
set :public, lambda { File.join(root, "public") }

# ==========================================================
# Actions
# ==========================================================

get '/' do
  erb :index
end

post '/' do
  @link = case link = params[:link]
  when /^http/i then link
  when /#{'http'.reverse}$/i then link.reverse
  when /=$/ then Base64.decode64(link)
  else
    @erro = "Não foi possível resolver a url informada."
    nil
  end
  erb :index
end

# ==========================================================
# Helpers
# ==========================================================

helpers do
  def get_clippy text, bgcolor = '#FFFFFF'
    %Q{
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" width="110" height="14" id="clippy" >
          <param name="movie" value="/flash/clippy.swf"/>
          <param name="allowScriptAccess" value="always" />
          <param name="quality" value="high" />
          <param name="scale" value="noscale" />
          <param NAME="FlashVars" value="text=#{text}">
          <param name="bgcolor" value="#{bgcolor}">
          <embed src="/flash/clippy.swf"
                 width="110"
                 height="14"
                 name="clippy"
                 quality="high"
                 allowScriptAccess="always"
                 type="application/x-shockwave-flash"
                 pluginspage="http://www.macromedia.com/go/getflashplayer"
                 FlashVars="text=#{text}"
                 bgcolor="#{bgcolor}"
          />
      </object>
    }
  end
end