require 'rails_helper'

RSpec.describe Api::V1::DocumentsController, type: :controller do
  describe "GET #show" do
    before(:each) do
      @document = FactoryGirl.create :document
      get :show, params: { id: @document.id }
    end

    it "returns the information about a reporter on a hash" do
      document_response = json_response
      expect(document_response[:name]).to eql @document.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :document }
      get :index
    end

    it "returns 4 records from the database" do
      documents_response = json_response
      expect(documents_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        folder = FactoryGirl.create :folder, user: user
        @document_attributes = FactoryGirl.attributes_for :document
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, folder_id: folder.id,
          document: @document_attributes }
      end

      it "renders the json representation for the document record just created" do
        document_response = json_response
        expect(document_response[:name]).to eql @document_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        folder = FactoryGirl.create :folder, user: user
        @invalid_document_attributes = { name: "Apuntes 1", pages: 15 }
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, folder_id: folder.id,
          document: @invalid_document_attributes }
      end

      it "renders an errors json" do
        document_response = json_response
        expect(document_response).to have_key(:errors)
      end

      it "renders the json errors on whye the user could not be created" do
        document_response = json_response
        expect(document_response[:errors][:url]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
end
