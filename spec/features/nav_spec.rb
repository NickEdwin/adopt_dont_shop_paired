RSpec.describe 'as a visitor' do
  describe 'when I visit any page on the site' do
    it 'then I see links at the top for pet index and shelter index' do

      shelter = Shelter.create!({name: "Braun Farm", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
      pet = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id)

      visit "/shelters"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/pets"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/shelters/#{shelter.id}"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/pets/#{pet.id}"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/shelters/#{shelter.id}/pets"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/shelters/#{shelter.id}/edit"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/pets/#{pet.id}/edit"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/shelters/new"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')

      visit "/shelters/#{shelter.id}/pets/new"
      expect(page).to have_link('Pets')
      expect(page).to have_link('Shelters')
    end
  end
end
