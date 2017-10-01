require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
end

helpers do
  def usernamese
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end


get '/' do
   erb 'Can you handle a <a href="/secure/place">secret</a>?'
end

get '/login/form' do
  @pass = params[:pass]
  @mail = params[:mail]

  if @pass == 'admin@mail.ru' && @mail == 'admin'
     erb :about
   else
     erb :login_form
  end

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


get '/about' do
  erb :about
end

get '/visit' do
  erb :visit  
end

get '/contacts' do
  erb :contacts
end

