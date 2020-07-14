RSpec.describe 'As a visitor' do
  it 'see list of pets from specific shelter including each pet image, name, approx age, and sex' do

    shelter = Shelter.create!(name: "Braun Farm")
    shelter2 = Shelter.create!(name: "Jax Rescue")

    pet1 = Pet.create!(name: 'Noodle', approx_age: 3, sex: "male", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id )

    pet2 = Pet.create!(name: 'Marley', approx_age: 12, sex: "female", image: "https://s3-eu-west-1.amazonaws.com/w3.cdn.gpd/gb.pedigree.56/large_e6bfdad9-6951-407b-a11f-bbd0c25bd796.jpg", shelter_id: shelter.id)

    pet3 = Pet.create!(name: 'Leo', approx_age: 7, sex: 'male', image: "", shelter_id: shelter2.id)

    visit "/shelters/#{shelter.id}/pets"

    expect(page).to have_content("Noodle")
    expect(page).to have_content("#{pet1.approx_age}")
    expect(page).to have_content("male")

    expect(page).to have_xpath("//img[@src = 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg' and @alt='photo of pet']")

    expect(page).to have_content("Braun Farm")
    expect(page).to have_content("Marley")
    expect(page).to have_selector(:link_or_button, 'Update')
    expect(page).to have_selector(:link_or_button, 'Delete')

    expect(page).to_not have_content("Leo")
  end
end
