require 'net/http'
require 'net/https'

class Api::V1::JobsController < ApplicationController
before_action :authenticate_with_token!, only: :create

  def create
    document = Document.find_by(id: params[:job][:document_id])
    pages = document.pages
    balance = current_user.balance - calculate_price(pages)
    puts "HOLA VAMOS POR AQUI"
    puts current_user.balance
    if balance > 0
      if current_user.update(balance: balance)
        url = document.file.expiring_url(86400)
        curl = 'curl --data "{ \"url\": \"' << url << '\" }" https://jre.villas/print'
        system curl
        # TODO : comprobar lo que devuelve curl
        render json: { result: "OK" }, status: 200
      else
        render json: { errors: "Error updating balance" }, status: 422
      end
    else
      # TODO :  error no hay saldo suficiente
    end
  end

  private

    def calculate_price(pages)
      pages*0.04
    end

    def print_post
      # hacer post con libreria estandar
    end
end
