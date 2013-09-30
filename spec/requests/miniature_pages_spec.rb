require 'spec_helper'

describe "Miniature pages" do

  subject { page }

 describe "Miniature page" do
   let(:miniature) { FactoryGirl.create(:miniature) }
   before { visit miniature_path(miniature) }

   it { should have_content(miniature.name) }
   it { should have_title(miniature.name) }
 end

describe "add miniature" do

    before { visit new_path }

    let(:submit) { "Add miniature" }

    describe "with invalid information" do
      it "should not create a miniature" do
        expect { click_button submit }.not_to change(Miniature, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example Miniature"
        fill_in "Material",     with: "Metal"
        fill_in "Release Date",     with: "25/03/1981"
      end

      it "should create a miniature" do
        expect { click_button submit }.to change(Miniature, :count).by(1)
      end
    end
  end

end

