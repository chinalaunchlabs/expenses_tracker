class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActionController::ParameterMissing, with: :render_missing_parameters
  rescue_from ActiveModel::ForbiddenAttributesError, with: :render_forbidden_parameters
  rescue_from ActiveRecord::InvalidForeignKey, with: :render_cannot_delete
  rescue_from ActiveRecord::RecordNotUnique, with: :render_duplicate

  protect_from_forgery with: :null_session

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.record.errors, status: 422 }, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { error: exception.message, status: 404 }, status: :not_found
  end

  def render_missing_parameters(exception)
    render json: { error: "#{exception.param} is missing.", status: 400 }, status: :bad_request
  end

  def render_forbidden_parameters(exception)
    render json: { error: exception.message, status: 400 }, status: :bad_request
  end

  def render_cannot_delete(exception)
    render json: { error: exception.message, status: 409 }, status: 409
  end

  def render_duplicate(exception)
    render json: { error: exception.message, status: 422 }, status: 422
  end


  def append_info_to_payload(payload)
    super
    payload[:uid] = current_user.id if current_user != nil
  end

  protected

  def authorize_user!
    unless user_id_in_token?
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated'] }, status: :unauthorized
  end

  private

  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= JsonWebToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end

end
