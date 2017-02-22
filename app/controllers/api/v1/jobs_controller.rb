require 'net/http'
require 'net/https'

class Api::V1::JobsController < ApplicationController
before_action :authenticate_with_token!, only: :create

  def create
    document = Document.find_by(id: params[:job][:document_id])
    validate_document_id(document)
    balance = current_user.balance - calculate_price(document.pages)

    if balance > 0
      url = document.file.expiring_url(86400)
      if print_post(url) == "200"
        if current_user.update(balance: balance)
          render json: { message: "Print ok" }, status: 200
        else
          render json: { errors: "Error updating user" }, status: 422
        end
      else
        render json: { errors: "Error printing document" }, status: 422
      end
    else
      render json: { errors: "Not enough balance" }, status: 422
    end
  end

  private

    def calculate_price(pages)
      pages*0.04
    end

    def print_post(url)
      uri = URI.parse("https://jre.villas/print")
      request = Net::HTTP::Post.new(uri)
      request.body = JSON.dump({
        "url" => "#{url}"
        })

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      response.code
    end

    def validate_document_id(document)
      if document.user_id != 1 && document.user_id != current_user.id
        render json: { errors: "Unauthorized" }, status: :unauthorized
      end
    end
end
