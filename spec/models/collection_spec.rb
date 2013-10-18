require 'spec_helper'

describe Collection do
  
  let(:user) { FactoryGirl.create(:user) }
  before { @collection = user.collections.build(miniature_id: "1", status: "Have", progress: "Painted") }

  subject { @collection }

  it { should be_valid }

  describe "when user id is not present" do
    before { @collection.user_id = nil }
    it { should_not be_valid }
  end
  describe "when miniature id is not present" do
    before { @collection.miniature_id = nil }
    it { should_not be_valid }
  end
  describe "when status is not present" do
    before { @collection.status = nil }
    it { should_not be_valid }
  end
  describe "when progress is not present" do
    before { @collection.progress = nil }
    it { should_not be_valid }
  end
end
