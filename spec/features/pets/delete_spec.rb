RSpec.describe "as a visitor", type: :feature do
  describe 'destroy existing pet' do
    it 'by using delete pet link on pet show page, redirect to pets index' do

      shelter = Shelter.create(name: "Braun Farm")

      pet1 = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id, status: "adoptable" )

      visit "/pets/#{pet1.id}"
      click_on "Delete"
      expect(current_path).to eq("/pets")

      expect(page).to_not have_content('Noodle')

    end
  end
end
