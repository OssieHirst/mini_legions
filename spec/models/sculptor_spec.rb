require 'spec_helper'

describe Sculptor do

  before { @sculptor = Sculptor.create(first_name: "Terry", last_name: "Balls", biog: "Has horrible balls") }

  subject { @sculptor }

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:biog) }

  it { should be_valid }
end