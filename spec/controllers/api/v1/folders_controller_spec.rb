require 'rails_helper'

RSpec.describe Api::V1::FoldersController, type: :controller do

  describe "GET #show" do
    before(:each) do
      user = FactoryGirl.create :user
      @folder = FactoryGirl.create :folder
      get :show, params: { id: @folder.id }
    end

    it "returns the information about a reporter on a hash" do
      folder_response = json_response
      expect(folder_response[:name]).to eql @folder.name
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      user = FactoryGirl.create :user
      4.times { FactoryGirl.create :folder }
      get :index
    end

    it "returns 4 records from the database" do
      folders_response = json_response
      expect(folders_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      before(:each) do
        user = FactoryGirl.create :user
        @folder_attributes = FactoryGirl.attributes_for :folder
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, folder: @folder_attributes }
      end

      it "renders the json representation for the folder record just created" do
        folder_response = json_response
        expect(folder_response[:name]).to eql @folder_attributes[:name]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        user = FactoryGirl.create :user
        @invalid_folder_attributes = { name: "" }
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, folder: @invalid_folder_attributes }
      end

      it "renders an errors json" do
        folder_response = json_response
        expect(folder_response).to have_key(:errors)
      end

      it "renders the json errors on why the folder could not be created" do
        folder_response = json_response
        expect(folder_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    before(:each) do
      @user = FactoryGirl.create :user
      @folder = FactoryGirl.create :folder, user: @user
      api_authorization_header @user.auth_token
    end

    context "when is successfully updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @folder.id,
              folder: { name: "New folder 2" } }
      end

      it "renders the json representation for the updated user" do
        folder_response = json_response
        expect(folder_response[:name]).to eql "New folder 2"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      before(:each) do
        patch :update, params: { user_id: @user.id, id: @folder.id,
              folder: { name: "" } }
      end

      it "renders an errors json" do
        folder_response = json_response
        expect(folder_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        folder_response = json_response
        expect(folder_response[:errors][:name]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      @folder = FactoryGirl.create :folder, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, params: { user_id: @user.id, id: @folder.id }
    end

    it { should respond_with 204 }
  end
end
