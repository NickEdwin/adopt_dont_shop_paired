RSpec.describe "visit /shelters/id", type: :feature do
  before :each do
    @shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
    @review1 = Review.create({title: "My great experience!", rating: 5, content: "I went here and loved it.", picture: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg", shelter_id: @shelter1.id})
    @review2 = Review.create({title: "My terrible experience!", rating: 0, content: "I went here and hated it.", picture: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg", shelter_id: @shelter1.id})
    @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter1.id )
    @pet2 = Pet.create(name: 'Yoda', approx_age: 4, sex: "male", description: "description of yoda", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter1.id)
    @application1 = Application.create(name: 'Timmy', address: '123 Street St.', city: 'Denver', state: 'CO', zip: '80218', phone_number: '303-123-4567', reason: 'Because I love animals!')
    ApplicationPet.create(application_id: @application1.id, pet_id: @pet1.id)
  end

  it "show given shelter's name, address, city, state, zip" do

    visit "/shelters"
    click_link(@shelter1.name)

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter1.address)
    expect(page).to have_content(@shelter1.city)
    expect(page).to have_content(@shelter1.state)
    expect(page).to have_content(@shelter1.zip)

    expect(page).to have_selector(:link_or_button, 'Update')
    expect(page).to have_selector(:link_or_button, 'Delete')
  end

  it "displayes a list of reviews including title, rating, content, and optional picture" do

    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content(@review1.title)
    expect(page).to have_content(@review1.rating)
    expect(page).to have_content(@review1.content)
    expect(page).to have_xpath("//img[@src = 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg' and @alt='review photo']")
  end

  it "add new review" do

    visit "/shelters/#{@shelter1.id}"
    click_on "Write Review"

    expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
  end

  it "displays count of pets that are at that shelter" do

    visit "/shelters/#{@shelter1.id}"

    within('#shelter') do
      expect(page).to have_content("(2)")
    end
  end

  it "average shelter review rating" do

    visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("average rating: 2.5 / 5.0")
  end

  it "number of applications on file for that shelter" do

    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content("1 application(s) on file")
  end
end
