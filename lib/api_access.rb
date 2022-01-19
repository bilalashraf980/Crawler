module ApiAccess
  
  def verify_api_auth(request, secret_key)
    begin
      req_header_content_type  = request.headers["Content-Type"]
      req_header_md5           = request.headers["Content-MD5"]
      req_path                 = request.path
      req_header_http_date     = request.headers["HTTP_DATE"]
      req_header_authorization = request.headers["HTTP_AUTHORIZATION"]
      
      api_logger.info("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
      api_logger.info(req_header_content_type)
      api_logger.info(req_header_md5)
      api_logger.info(req_path)
      api_logger.info(req_header_http_date)
      api_logger.info(req_header_authorization)
      api_logger.info(secret_key)
      api_logger.info("HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
      
      headers              = ApiAuth::Headers.new(request)
      api_canonical_string = headers.canonical_string
      api_canonical_array  = api_canonical_string.split(",")
      
      api_method        = api_canonical_array[0]
      api_content_type  = api_canonical_array[1]
      api_md5           = api_canonical_array[2]
      api_path          = api_canonical_array[3]
      api_http_date     = headers.timestamp
      api_authorization = headers.authorization_header
      
      is_request_too_old = Time.httpdate(headers.timestamp).utc < (Time.now.utc - 900)
      
      api_logger.info("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
      api_logger.info(api_content_type)
      api_logger.info(api_md5)
      api_logger.info(api_path)
      api_logger.info(api_http_date)
      api_logger.info(api_authorization)
      api_logger.info(api_canonical_string)
      api_logger.info("Too Old:#{is_request_too_old}")
      api_logger.info("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA")
    
    rescue => e
      api_logger.info(e)
    end
  
  end
  
  def api_restrict_access
    auth_token      = request.headers["AUTH-TOKEN"]
    if auth_token.present?
      find_user_session(auth_token)
    else
      respond_to do |format|
        format.json do
          render json: {resp_message: "Session Expired"}, status: 401
        end
      end
      
    end
  end
  
  def find_user_session(token)
    user_session = UserSession.find_by_auth_token(token)
    if user_session.present?
      sign_in  user_session.user
    else
      resp_data    = ''
      resp_status  = 0
      resp_message = 'Your session expired. Please login again.'
      resp_title   = 'Errors'
      resp_errors  = 'Session Expired'
      respond_to do |format|
        format.json do
          render json: {resp_data: resp_data,resp_status: resp_status,resp_message: resp_message,
                        resp_title: resp_title,resp_errors: resp_errors}, status: 401
        end
      end
      
    end
  end

  def api_logger
    @api_logger ||= Logger.new("#{Rails.root}/log/api_access.log")
  end
  

end