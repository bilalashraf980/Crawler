class UserSession < ApplicationRecord
  
  belongs_to :user

  def self.get_user_auth_token(user, user_session)
    user_session_obj                = UserSession.find_or_initialize_by user_id: user.id
    user_session_obj.auth_token     = SecureRandom.hex(100)
    user_session_obj.session_status = 'open'
    user_session_obj.device_token   = user_session[:device_token]
    user_session_obj.save(validate: false)
    user_session_obj.auth_token
  end
  
end
