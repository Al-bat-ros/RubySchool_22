require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end


get '/' do
   erb 'Can you handle a <a href="/secure/place">secret</a>?'
end

get '/login/form' do
  erb :login_form
end

post '/login/attempt' do
  session[:identity] = params['username']
  where_user_came_from = session[:previous_url] || '/'
  redirect to where_user_came_from
end

post '/visit' do
  @list = params[:list]
  @username = params[:username]
  @namber_phone = params[:namber_phone]
  @data_time = params[:data_time]

  f = File.open './public/user.txt','a'
  f.write "User:#{@username}, Phone:#{@namber_phone}, Data:#{@data_time}, Hairdresser:#{@list}"
  f.close

  erb :visit
end

post '/contacts' do
   erb :contacts
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged,out</div>"
end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit  
end

get '/contacts' do
  erb :contacts
end

