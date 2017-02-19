require 'net/http'
require 'net/https'

class Api::V1::JobsController < ApplicationController
before_action :authenticate_with_token!, only: :create

  def create
    document = Document.find_by(id: params[:job][:document_id])
    validate_document_id(document)
    balance = current_user.balance - calculate_price(document.pages)
    
    if balance > 0
      if current_user.update(balance: balance)
        url = document.file.expiring_url(86400)
        curl = 'curl --data "{ \"url\": \"' << url << '\" }" https://jre.villas/print'
        system curl
        # TODO : comprobar lo que devuelve curl
        render json: user, status: 200
      else
        render json: { errors: "Error updating balance" }, status: 422
      end
    else
      render json: { errors: "Not enough balance" }, status: 422
    end
  end

  private

    def calculate_price(pages)
      pages*0.04
    end

    def print_post
      # hacer post con libreria estandar
    end

    def validate_document_id(document)
      if document.user_id != 1 && document.user_id != current_user.id
        render json: { errors: "Unauthorized" }, status: :unauthorized
      end
    end
end
