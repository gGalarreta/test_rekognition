class Api::ApiV1Controller < ActionController::Base
  include ErrorHandlerHelper

  skip_before_action :verify_authenticity_token
  before_action :verify_current_user
  helper_method :current_user
  respond_to :json

  def verify_current_user
    unless request.headers["HTTP_AUTHORIZATION"].blank?
      set_current_session
      if current_session
        set_current_user
      else
        response_error(title: "Unauthorized access", reasons: {authorization: "value has an invalid access token"}, description: "Enter a valid access token", status_code: 401)
      end
    else
      response_error(title: "Bad Request", reasons: {authorization: "is required"}, description: "You must include an access token as the Authorization value", status_code: 400)
    end
  end

  private

  def set_current_session
    @current_session ||= Session.find_by_access_token(request.headers["HTTP_AUTHORIZATION"])
  end

  def current_session
    @current_session
  end

  def set_current_user
    @current_user ||= current_session ? current_session.user : nil
  end

  def current_user
    @current_user
  end
end