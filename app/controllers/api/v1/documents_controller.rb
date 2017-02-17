class Api::V1::DocumentsController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :show, :destroy]
  respond_to :json

  def show
    respond_with Document.find(params[:id])
  end

  def create
    document = current_user.documents.build(document_params)
    if document.save
      render json: document, status: 201
    else
      render json: { errors: document.errors }, status: 422
    end
  end

  def destroy
    document = current_user.documents.find(params[:id])
    document.destroy
    head 204
  end

  private

    def document_params
      folder_id = params[:document][:folder_id] || current_user.folders[0].id
      params.require(:document).permit(:name, :file).merge(folder_id: folder_id)
    end
end
