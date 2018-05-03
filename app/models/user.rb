class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :confirmable, :lockable, :timeoutable,
        :omniauthable, omniauth_providers: [:github,:twitter,:facebook,:google_oauth2]

  def self.create_from_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        user.email = provider_data.info.email 
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end  
  end

  def self.create_from_twitter_provider_data(provider_data)
      where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do | user |
        #user.email = provider_data.info[:nickname] unless provider_data.info.email
        provider_data.info
        user.email = provider_data.info[:nickname]+"@gmail.com" if provider_data.info.nickname
        binding.pry
        user.password = Devise.friendly_token[0,20]
        user.skip_confirmation!
      end
  end

  def google_oauth2
    @user = User.create_from_google_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end 
  end  

end