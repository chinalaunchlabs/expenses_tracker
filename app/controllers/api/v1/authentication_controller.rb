class Api::V1::AuthenticationController < ApplicationController
  def sign_up
    @user = User.new(create_params)
    if @user.save!
      render json: {
        message: "Successfully signed up!",
        token: JsonWebToken.encode({user_id: @user.id}),
        user: @user.as_json(only: [:id, :name, :email])
      }, status: :ok
    end
  rescue Exception => e
    render json: { error: e }, status: 400
  end

  def sign_in
    @user = User.find_by email: params[:email]
    if @user.valid_password?(params[:password])
      render json: {
        message: "Successfully signed in!",
        token: JsonWebToken.encode({user_id: @user.id}),
        user: @user.as_json(only: [:id, :name, :email])
      }, status: :ok
    else
      render json: { error: "Could not log in." }, status: :unauthorized
    end
  end

  def validate_session

  end

  private
    def create_params
      params.permit(:email, :name, :password)
    end
end
