class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: {case_sensitive: true}
  has_many :user_sessions

  def self.sign_in(data)
    if data[:user][:email].present?
      user = User.find_by_email(data[:user][:email])
    end
    if user && user.valid_password?(data[:user][:password])
        response = user.user_response(data[:user_session])
        status =  "200"
        resp_data    = response
        message = 'User Logged In successful.'
    else
      status = "401"
      message = 'Either your Email or password is incorrect.'
    end
    [status,message,resp_data]
  end

  def user_response(user_session, auth_token = nil)
    if auth_token.blank?
      auth_token = UserSession.get_user_auth_token(self, user_session)
    end
    response = self.as_json(
        only: [:id,:email]
    ).merge!(auth_token: auth_token).as_json
  end
  
end
