require 'bundler/setup'
require 'rack/rewrite'
require 'sinatra/base'
require 'rack/protection'

# The project root directory
$root = ::File.dirname(__FILE__)

use Rack::Protection,  :except => :session_hijacking

use Rack::Rewrite do
  r301 %r{.*}, 'http://www.scottw.com$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] != 'www.scottw.com' && ENV['RACK_ENV'] == 'production'
  }
  
  r301 %r{^/life|code|business|software(/.+)}, '$1'
  r301 %r{^/archive$}, '/archives'
  r301 %r{^(.+)/$}, '$1'
  r301 %r{^/tags}, '/'
  r301 %r{^/atom$}, '/atom.xml'  
end

class SinatraStaticServer < Sinatra::Base  
	set :public, 'public'

  get(/.+/) do
    send_sinatra_file(request.path) {404}
  end

  not_found do
    send_sinatra_file('404.html') {"Sorry, I cannot find #{request.path}"}
  end

  def send_sinatra_file(path, &missing_file_block)
    file_path = File.join(File.dirname(__FILE__), 'public',  path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i  
    File.exist?(file_path) ? send_file(file_path) : missing_file_block.call
  end

end

run SinatraStaticServer
