class Api::V1::FoldersController < ApplicationController
  before_action :authenticate_with_token!, only: [:create, :update, :show, :destroy]
  respond_to :json

  def show
    respond_with Folder.find(params[:id])
  end

  def create
    folder = current_user.folders.build(folder_params)
    if folder.save
      render json: folder, status: 201
    else
      render json: { errors: folder.errors }, status: 422
    end
  end

  def update
    folder = current_user.folders.find(params[:id])
    if folder.update(folder_params)
      render json: folder, status: 200
    else
      render json: { errors: folder.errors }, status: 422
    end
  end

  def destroy
    folder = current_user.folders.find(params[:id])
    folder.destroy
    head 204
  end

  private

    def folder_params
      params.require(:folder).permit(:name)
    end
end
