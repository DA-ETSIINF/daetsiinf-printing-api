class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  def create
    super
  end
end
