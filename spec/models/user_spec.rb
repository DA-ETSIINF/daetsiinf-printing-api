require 'rails_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:auth_token) }

  it { should be_valid }

  it { should validate_presence_of(:email) }
  it { should_not validate_uniqueness_of(:email) }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@alumnos.upm.es').for(:email) }
  it { should_not validate_uniqueness_of(:auth_token) }

  it { should have_many(:folders) }

  describe "#generate_authentication_token!" do
    it "generates a unique token" do
      allow(Devise).to receive(:friendly_token).and_return("auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).to eql "auniquetoken123"
    end

    it "generates another token when one already has been taken" do
      existing_user = FactoryGirl.create(:user, auth_token: "auniquetoken123")
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eql existing_user.auth_token
    end
  end

  describe "#folders association" do

    before do
      @user.save
      3.times { FactoryGirl.create :folder, user: @user }
    end

    it "destroys the associated folders on self destruct" do
      folders = @user.folders
      @user.destroy
      folders.each do |f|
        expect { Folder.find(f.id) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
