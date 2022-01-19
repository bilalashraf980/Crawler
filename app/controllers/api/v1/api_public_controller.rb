class Api::V1::ApiPublicController < ApplicationController
  
  include ApiAccess
  
  after_action :cors_set_access_control_headers
  
  resource_description do
    api_version "Public - V 1.0"
  end
  
  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin']      = '*'
    headers['Access-Control-Allow-Methods']     = 'POST,GET,PUT,DELETE,OPTIONS'
    headers['Access-Control-Max-Age']           = '1728000'
    headers['Access-Control-Allow-Credentials'] = 'true'
  end
  
end
