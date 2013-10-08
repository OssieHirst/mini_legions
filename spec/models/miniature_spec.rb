require 'spec_helper'

describe Miniature do

  before do  @miniature = Miniature.new(name: "Example Miniature", material: "Metal", release_date: "25/03/1981", scale: "28mm")
  end
   subject { @miniature }
 

  it { should respond_to(:name) }
  it { should respond_to(:material) }
  it { should respond_to(:release_date) }
  it { should respond_to(:scale) }
  it { should respond_to(:productions) }
  it { should respond_to(:manufacturers) }

  it { should be_valid }

  describe "when name is not present" do
    before { @miniature.name = " " }
    it { should_not be_valid }
  end
  describe "when material is not present" do
    before { @miniature.material = " " }
    it { should_not be_valid }
  end
  describe "when scale is not present" do
    before { @miniature.scale = " " }
    it { should_not be_valid }
  end
  describe "when release date is not valid" do
    before { @miniature.release_date = "ddddddd" }
    it { should_not be_valid }
  end
   describe "when name is too long" do
    before { @miniature.name = "a" * 51 }
    it { should_not be_valid }
  end
end