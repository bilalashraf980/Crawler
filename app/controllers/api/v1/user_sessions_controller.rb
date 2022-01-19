module Api
  module V1
    class UserSessionsController < ApiPublicController
      api :POST, '/v1/user_sessions/sign_in.json', "Login"
      formats ['json', 'xml']
      example <<-EOS
        Request:
        {
          "user":{
            "email": "xxxx",
            "password": "xxxxxxxxx"
          },
          "user_session": {
            "device_token" :"xxx"
          }
        }
        HEADER: {
          "Content-Type": "application/json"
        }
      
        Status Codes with Response
        200:{
              "id": 4,
              "email": "bilalashraf@yahoo.com",
              "auth_token": "asdasdfasdfasdf97797987fasdfasdfasd"
            }

        404: {"resp_message": "User Not Found"}

        403: {"resp_message": "xxxxxxxxxxxx"}

        401: {"resp_message": "Your session expired. Please login again."}

        400: {"resp_message": "xxxxxxxxxx"}
      EOS
      
      param :user, Hash, desc: 'Login credentials' do
        param :email, String, desc: 'Username', required: true
        param :password, String, desc: 'Password', required: true
      end
      
      param :user_session, Hash, desc: 'User Session' do
        param :device_token, String, desc: 'device token', required: true
      end
      
      def sign_in
        @status, @message ,@resp_data= User.sign_in(params)
        if @status  == "200"
          render json:  @resp_data, status: 200
        else @status == "401"
          render json:  {message: @message}, status: 400
        end
      end
    end
  end
end
