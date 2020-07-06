RSpec.describe 'as a visitor' do
  describe 'when I visit /pets' do
    it 'then I see each Pet in the system including image, name, approximate age, sex, name of shelter' do

      shelter = Shelter.create(name: "Braun Farm")
      pet1 = Pet.create!(name: 'Noodle', approx_age: 3, sex: "M", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id, status: 'adoptable' )
      pet2 = Pet.create!(name: 'Marley', approx_age: 12, sex: "F", image: "", shelter_id: shelter.id, status: 'adoptable')

      visit '/pets'

      expect(page).to have_content("Noodle")
      expect(page).to have_content("#{pet1.approx_age}")
      expect(page).to have_content("#{pet1.sex}")

      expect(page).to have_xpath("//img[@src = 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg' and @alt='photo of pet']")

      expect(page).to have_content("Braun Farm")
      expect(page).to have_content("Marley")

      expect(page).to have_selector(:link_or_button, 'Update')
      expect(page).to have_selector(:link_or_button, 'Delete')
    end
  end
end
