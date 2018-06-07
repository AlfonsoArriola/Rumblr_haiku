require 'sinatra'
require './models'
require 'securerandom'

SecureRandom.hex
  
set :session_secret, ENV['SEI_SESSION_SECRET']
enable :sessions


get '/' do
	erb :index
	# ,	:layout =>false
end


get('/signup') do
	erb :signup
end

get('/how_to') do
	erb :how_to ,	:layout =>false
end

post('/signup') do
	existing_user = User.find_by(email: params[:email])
	if existing_user != nil
		return redirect '/login'
	end

	user = User.create(
		first_name: params[:f_name],
  		last_name: params[:l_name],
  		email: params[:email],
  		password: params[:password],
  		birthday: params[:birthday]
	)
	session[:user_id] = user.id
	redirect '/dashboard'
end

get('/login') do 
	erb :login	
end

post('/login') do
	user = User.find_by(email: params[:user_email])
	if user.nil?
		return redirect '/login'
	end

	unless user.password == params[:password]
		return redirect '/login'
	end

	session[:user_id] = user.id
	redirect '/dashboard'
end


get ('/logout') do
	session.clear
	redirect '/' 
end


get('/dashboard') do
	user_id = session[:user_id]
	if user_id.nil?
		return redirect '/'
	end

	@user = User.find(user_id)
    @poems = @user.poems
    @num = []
	erb :dashboard, :layout =>false
end	


get '/haiku/new' do
	erb :new
end

post '/haiku/create' do

# _____________  haiku finder  ____________________

	user_id = session[:user_id]
    haiku = params[:poem]
    # no_spaces_or_puncuations = are_you_a_haiku.gsub!(/\W+/, ' ')
    # now_imma_array = no_spaces_or_puncuations.split(' ')
   # def  are_you_a_haiku(haiku)
		 #  haiku1 = haiku.downcase!
		 #  haiku2 = haiku1.sub!(/(?:[^laeiouy]es|ed|[^laeiouy]e)$/, '')
		 #  haiku3 haiku2.sub!(/^y/, '')
   #         haiku4 = haiku3.scan(/[aeiouy]{1,2}/).size
      
   #            if haiku4 > 0
   #            	 poem = Poem.create(
			# 			title: params[:title],
			# 			poem: haiku,
			# 			user_id: user_id
			# 			)
          
			# 		redirect '/dashboard' 
			# 	else
			# 		redirect '/haiku/new'
			# 		puts haiku
			# 	end
			
   #   end
# ______________  BASIC POEM ANALYZER  _____________________________

    user_id = session[:user_id]
	poem = Poem.create(
		title: params[:title],
		poem: params[:poem],
		user_id: user_id
		)

	# --------------------------------------------
	redirect '/dashboard'
end

get '/haiku/edit/:id' do
	# @poem = poem.find(params[])
	user_id = session[:user_id]
   @user = User.find(user_id)
   @poems = @user.poems.find(params[:id])
	erb :edit
end

post '/haiku/update/:id' do
	# posts = track_user_posts.find(params[:id])
	# posts.update(params)
	user_id = session[:user_id]
   @user = User.find(user_id)
   @poems = @user.poems.find(params[:id])
   @poems.update(title: params[:title]  , poem:params[:poetry])

	redirect '/dashboard'	
end

get '/haiku/delete/:id'do 
user_id = session[:user_id]
   @user = User.find(user_id)
   @poems = @user.poems.find(params[:id])
   @poems.destroy()

   redirect '/dashboard'	

end

get '/profile' do
	user_id = session[:user_id]
   @user = User.find(user_id)
   @poems = @user.poems.order('id DESC')
   # @poems = Poems.where(user_id: session[:user_id])

	erb :profile
end

get '/cancel' do
	user_id = session[:user_id]
   @user = User.find(user_id)
   @user.destroy()
	redirect '/'
end

get '/haiku/public_profile/:id' do
	# @poem = poem.find(params[])
	user_id = session[:user_id]
    @user = User.find(user_id)
    @poems = @user.poems.find(params[:id])
	erb :public_profile
end







