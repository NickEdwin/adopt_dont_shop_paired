RSpec.describe "destroy existing shelter", type: :feature do
  it "uses 'delete shelter' link to delete given shelter, and redirect to index" do

    shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    visit "/shelters/#{shelter1.id}"
    click_on "Delete"
    expect(current_path).to eq("/shelters")

    expect(page).to_not have_content('Shelter 1')
  end

  it "deletes reviews associated with shelter when shelter is deleted" do

    shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
    review = shelter1.reviews.create!({title: "Best place ever!", rating: 5, content: "Love my Doggo!", picture: "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg"})

    visit "/shelters/#{shelter1.id}"

    within('#shelter') do
      click_on "Delete"
    end

    expect { review.reload }.to raise_error ActiveRecord::RecordNotFound
  end

  it 'can\'t be deleted if there are pets with pending applications' do

    shelter = Shelter.create({name: "Braun Farm", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
    pet = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: shelter.id )

    application = Application.create(name: 'Timmy', address: '123 Street St.', city: 'Denver', state: 'CO', zip: '80218', phone_number: '303-123-4567', reason: 'Because I love animals!')

    ApplicationPet.create(application_id: application.id, pet_id: pet.id)

    application.approve_for(pet)
    expect(pet.status).to eq(:pending)

    visit "/shelters"
    click_on "Delete"

    expect(current_path).to eq("/shelters")
    expect(page).to have_content('Braun Farm')
    expect(page).to have_content('Shelters with pending applications can\'t be deleted.')
  end
end
