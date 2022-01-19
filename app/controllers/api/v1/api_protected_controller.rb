module Api
  module V1
    class ApiProtectedController < ApiPublicController
      include ApiAccess
      after_action :cors_set_access_control_headers
      before_action :api_restrict_access
      
      # rescue_from CanCan::AccessDenied do |exception|
      #   cancan_exception_response(exception)
      # end
      
      unless Rails.application.config.consider_all_requests_local
        rescue_from Exception, with: :cancan_exception_response
      end
      
      
      def cancan_exception_response(e)
        resp_message = 'Your session expired. Please login again.'
        respond_to do |format|
          format.json do
            render json: {message: resp_message}, status: 401
          end
        end
      end
      
      
      resource_description do
        api_version "Private - V 1.0"
        app_info "All APIs need Authorization token in HTTP header received in Login response.
        AUTH-TOKEN=Aj1DzQc06IwaT467V7sq5gZZ,"
      end
      
      def cors_set_access_control_headers
        headers['Access-Control-Allow-Origin']      = '*'
        headers['Access-Control-Allow-Methods']     = 'POST, GET, OPTIONS'
        headers['Access-Control-Max-Age']           = '1728000'
        headers['Access-Control-Allow-Credentials'] = 'true'
      end
    end
  end
end
