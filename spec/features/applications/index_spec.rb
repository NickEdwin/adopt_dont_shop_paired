RSpec.describe 'as a visitor' do
  before :each do
    @shelter = Shelter.create(name: "Braun Farm")
    @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id)
    @pet2 = Pet.create(name: 'Yoda', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter.id)
    @application1 = Application.create(name: 'Timmy', address: '123 Street St.', city: 'Denver', state: 'CO', zip: '80218', phone_number: '303-123-4567', reason: 'Because I love animals!')
    ApplicationPet.create(application_id: @application1.id, pet_id: @pet1.id)
  end

  it 'Displays outstanding applications for a pet' do
    visit "/pets/#{@pet1.id}"

    click_on "See Applicants"

    expect(current_path).to eq("/applications")

    click_on "Timmy"

    expect(current_path).to eq("/applications/#{@application1.id}")
  end

  it 'Displays that a pet has no applicants' do
    visit "/pets/#{@pet2.id}"

    click_on "See Applicants"

    expect(current_path).to eq("/applications")

    expect(page).to have_content("There are no current applications for this pet.")
  end
end
