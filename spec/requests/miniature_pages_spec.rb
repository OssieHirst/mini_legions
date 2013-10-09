require 'spec_helper'

describe "Miniature pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

 describe "Miniature page" do
   let(:miniature) { FactoryGirl.create(:miniature) }
   before { visit miniature_path(miniature) }

   it { should have_content(miniature.name) }
   it { should have_title(miniature.name) }
   it { should have_content(miniature.release_date.strftime("%d %b %Y")) }
   it { should have_content(miniature.material)}
   it { should have_content("01 Dec 2001")}
   it {should have_link('Edit this miniature listing', href: edit_miniature_path(miniature)) }
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
      end

      it "should create a miniature" do
        expect { click_button submit }.to change(Miniature, :count).by(1)
      end
    end
  end

  describe "edit" do
  	let(:miniature) { FactoryGirl.create(:miniature) }
   before { visit edit_miniature_path(miniature) }

   it { should have_content("Edit miniature listing") }

     describe "with valid information" do
      let(:new_name)  { "New Name" }
      before do
        fill_in "Name",         with: "new_name"
        click_button "Save changes"
      end
      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(miniature.reload.name).to  eq new_name }
    end
  end

describe "index" do
    let(:miniature) { FactoryGirl.create(:miniature) }

    before(:each) do
      sign_in user
      visit miniatures_path
    end

    it { should have_title('All miniatures') }
    it { should have_content('All miniatures') }

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let!(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit miniatures_path
        

        it { should have_link('delete', href: miniature_path(Miniature.first)) }
        it "should be able to delete miniatures" do
          expect do
            click_link('delete', match: :first)
          end.to change(Miniature, :count).by(-1)
        end
       end
      end
    end

    describe "pagination" do

      before(:all) { 40.times { FactoryGirl.create(:miniature) } }
      after(:all)  { Miniature.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each miniature" do
        Miniature.paginate(page: 1).each do |miniature|
          expect(page).to have_selector('td', text: miniature.name)
        end
      end
    end

    

  end

end