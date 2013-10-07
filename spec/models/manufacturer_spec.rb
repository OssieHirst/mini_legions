require 'spec_helper'

describe Manufacturer do

  before { @manufacturer = Manufacturer.create(name: "Example Manufacturer") }

  subject { @manufacturer }

  it { should respond_to(:name) }
  it { should respond_to(:productions) }
  it { should respond_to(:miniatures) }

  it { should be_valid }
end