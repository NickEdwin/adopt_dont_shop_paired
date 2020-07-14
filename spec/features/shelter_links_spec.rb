RSpec.describe 'as a visitor' do
  describe 'When I click on the name a shelter anywhere on the site' do
    it 'then that link takes me to that shelters\'s show page' do

      shelter = Shelter.create(name: "Braun Farm")

      pet1 = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id )


      visit '/shelters'
      click_on "#{shelter.name}"
      expect(current_path).to eq("/shelters/#{shelter.id}")

      # visit "/shelters/#{shelter.id}/pets"
      # click_on "#{shelter.name}"
      # expect(current_path).to eq("/shelters/#{shelter.id}")
    end
  end
end
