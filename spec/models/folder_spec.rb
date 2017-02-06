require 'rails_helper'

RSpec.describe Folder, type: :model do
  before { @folder = FactoryGirl.build(:folder) }

  subject { @folder }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:user) }

  describe "#documents association" do

    before do
      @folder.save
      3.times { FactoryGirl.create :document, folder: @folder }
    end

    it "destroys the associated documents on self destruct" do
      documents = @folder.documents
      @folder.destroy
      documents.each do |doc|
        expect { Document.find(doc) }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
