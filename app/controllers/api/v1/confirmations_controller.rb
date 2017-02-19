class Api::V1::ConfirmationsController < ApplicationController
  respond_to :json

  def confirm
    # Get token from url params
    token = params[:confirmation_token]

    # Check if there is an existing user with given token
    if user = User.find_by(confirmation_token: token)
      # Confirm user
      if user.update(is_verified: true)
        # TODO: Redirect to login screen
        redirect_to "http://da.etsiinf.upm.es"
      else
        # Error confirming user
        render json: { errors: "Error updating user" }, status: 400
      end
    else
      # Invalid confirmation token
      render json: { errors: "Invalid token" }, status: 400
    end
  end
end
