require 'spec_helper'

describe Scale do

  before { @scale = Scale.create(name: "20mm") }

  subject { @scale }

  it { should respond_to(:name) }
  it { should respond_to(:sizes) }
  it { should respond_to(:miniatures) }

  it { should be_valid }
end