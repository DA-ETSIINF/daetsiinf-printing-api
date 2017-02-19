class Api::V1::ConfirmationsController < ApplicationController
  respond_to :json

  def confirm
    token = params[:confirmation_token]

    if user = User.find_by(confirmation_token: token)
      if user.update(is_verified: true)
        redirect_to "http://da.etsiinf.upm.es"
      else
        render json: { errors: "Error updating user" }, status: 400
      end
    else
      render json: { errors: "Invalid token" }, status: 400
    end
  end
end
