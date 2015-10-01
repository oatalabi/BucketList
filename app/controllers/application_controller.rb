include ActionController::HttpAuthentication::Token::ControllerMethods
include ActionController::Serialization

class ApplicationController < ActionController::API
  
  rescue_from Exception, with: :render_500

  before_filter :add_allow_credentials_headers

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @user = User.find_by(token: token)
    end
  end

  def render_unauthorized
    render json: {message: "pls login to access page"}
  end

  def find_user
    authenticate_token
    render json: { message: 'you are not authorized to view this page' } unless @user
  end

  def add_allow_credentials_headers
    response.headers['Access-Control-Allow-Origin'] = request.headers['Origin'] || '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def render_500
    render json: { error: "internal server error", status: 500 }, status: 500
  end
end
