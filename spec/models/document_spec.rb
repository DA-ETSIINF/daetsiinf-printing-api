require 'rails_helper'

RSpec.describe Document, type: :model do
  let(:document) { FactoryGirl.build :document }
  subject { document }

  it { should respond_to(:name) }
  it { should respond_to(:url) }
  it { should respond_to(:pages) }
  it { should respond_to(:folder_id) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :url }
  it { should validate_numericality_of(:pages).is_greater_than(0) }
  it { should validate_presence_of :folder_id }

  it { should belong_to :folder }
end
