class Users::OmniauthController < ApplicationController
  # github callback
	def github
	  @user = User.create_from_provider_data(request.env['omniauth.auth'])
	  if @user.persisted?
	    sign_in_and_redirect @user
	    if is_navigational_format?
          flash[:success] = "Welcome to the Rails app you are authenticated! with github"
	    end 
	  else
	  	binding.pry
	  	flash[:error] = 'There was a problem signing you in through Github. Please register or try signing in later.'
	  	@user.errors.full_messages do |msg|
          flash[:error] = msg
	  	end
	    redirect_to new_user_registration_url
	  end
	end

	# twitter callback
	def twitter
	  @user = User.create_from_provider_data(request.env['omniauth.auth'])
	  #binding.pry	
	  if @user.persisted?
	    sign_in_and_redirect @user
	    if is_navigational_format?
          flash[:success] = "Welcome to the Rails app you are authenticated! with twitter"
	    end 	
	  else
	    flash[:error] = 'There was a problem signing you in through Twitter. Please register or try signing in later.'
	    redirect_to new_user_registration_url
	  end 
	end

	def failure
        flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
        redirect_to new_user_registration_url
    end

end
