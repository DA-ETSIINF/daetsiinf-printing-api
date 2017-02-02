require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:folder) { FactoryGirl.build :folder }
  subject { folder }

  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user_id) }

  it { should belong_to(:user) }
end
