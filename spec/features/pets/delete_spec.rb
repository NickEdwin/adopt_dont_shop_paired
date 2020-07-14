RSpec.describe "as a visitor", type: :feature do
  describe 'destroy existing pet' do
    before :each do
      @shelter = Shelter.create!({name: "Braun Farm", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

      @pet = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id )

      @application = Application.create!(name: 'Timmy', address: '123 Street St.', city: 'Denver', state: 'CO', zip: '80218', phone_number: '303-123-4567', reason: 'Because I love animals!')

      ApplicationPet.create!(application_id: @application.id, pet_id: @pet.id)
    end

    it 'by using delete pet link on pet show page, redirect to pets index' do

      visit "/pets/#{@pet.id}"
      click_on "Delete"
      expect(current_path).to eq("/pets")

      expect(page).to_not have_content('Noodle')
    end

    it 'can\'t delete pet with pending applicaton' do

      @application.approve_for(@pet)
      expect(@pet.status).to eq(:pending)

      visit "/pets/#{@pet.id}"
      click_on "Delete"

      expect(current_path).to eq("/pets/#{@pet.id}")
      expect(page).to have_content('Noodle')
      expect(page).to have_content('Cannot delete a pet with pending application.')
    end
  end
end
