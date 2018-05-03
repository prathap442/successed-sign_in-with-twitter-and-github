class Users::OmniauthController < ApplicationController
  # github callback 
	def github
	  #binding.pry
	  #User.delete_all
	  @user = User.create_from_provider_data(request.env['omniauth.auth'])
	  if @user.persisted?
	    sign_in_and_redirect @user
	    if is_navigational_format?
          flash[:success] = "Welcome to the Rails app you are authenticated! with github"
	    end 
	  else
	  	arr1 = []
	  	@user.errors.full_messages do |msg|
          arr1.push(msg)
	  	end
	    redirect_to new_user_registration_url
	  end
	end

	# twitter callback
	def twitter
	  @user = User.create_from_twitter_provider_data(request.env['omniauth.auth'])
	  #binding.pry	
	  if @user.persisted?
	    sign_in_and_redirect @user
	    if is_navigational_format?
          flash[:success] = "Welcome to the Rails app you are authenticated! with twitter"
	    end 	
	  else
	  	arr1=[]
	  	@user.errors.full_messages.each do |msg|
          arr1.push(msg)
	    end
	    flash[:error] = arr1
	    redirect_to new_user_registration_url
	  end 
	end
    

    def facebook
	  @user = User.create_from_provider_data(request.env['omniauth.auth'])
	  #binding.pry
	  if @user.persisted?
	    sign_in_and_redirect @user
	    if is_navigational_format?
          flash[:success] = "Welcome to the Rails app you are authenticated! with facebook"
	    end 
	  else
	    flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
	    redirect_to new_user_registration_url
	  end 
    end

    def google_oauth2
    	@user = User.create_from_provider_data(request.env['omniauth.auth'])
		if @user.persisted?
		  sign_in_and_redirect @user
		  flash[:success] = "Welcome to the Rails app you are authenticated! with Google" if is_navigational_format?
		else
		  flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later. This is due to'+ @user.errors.full_messages.to_s
		  redirect_to new_user_registration_url
		end 
    end


	def failure
        flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
        redirect_to new_user_registration_url
    end

end
