require 'spec_helper'

describe Miniature do

  before { @miniature = Miniature.create(name: "Example Miniature", material: "Metal", release_date: "25/03/1981") }

  subject { @miniature }

  it { should respond_to(:name) }
  it { should respond_to(:material) }
  it { should respond_to(:release_date) }

  it { should be_valid }

  describe "when name is not present" do
    before { @miniature.name = " " }
    it { should_not be_valid }
  end
  describe "when material is not present" do
    before { @miniature.material = " " }
    it { should_not be_valid }
  end
  describe "when release date is not present" do
    before { @miniature.release_date = " " }
    it { should_not be_valid }
  end
   describe "when name is too long" do
    before { @miniature.name = "a" * 51 }
    it { should_not be_valid }
  end
end