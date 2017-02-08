class Api::V1::DocumentsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create]
  respond_to :json

  def show
    respond_with Document.find(params[:id])
  end

  def index
    respond_with Document.all
  end

  def create
    folder = current_user.folders.find(params[:folder_id])
    document = folder.documents.build(document_params)
    if document.save
      render json: document, status: 201, location: [:api, document]
    else
      render json: { errors: document.errors }, status: 422
    end
  end

  private

    def document_params
      params.require(:document).permit(:name, :file)
    end
end
