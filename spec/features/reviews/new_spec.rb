RSpec.describe "write new review", type: :feature do

  it "uses 'write review' link to visit /shelters/:id/reviews/new, fill out form, save new review, and redirect to shelter show page" do

    shelter = Shelter.create!({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    visit "/shelters/#{shelter.id}"
    click_link "Write Review"
    expect(current_path).to eq("/shelters/#{shelter.id}/reviews/new")

    fill_in('title', with: 'Test Review')
    fill_in('rating', with: '4')
    fill_in('content', with: 'Test Content')
    fill_in('picture', with: 'https://petfbi.org/wp-content/uploads/2012/10/dog-shelter.jpg')

    click_on('Save Review')
    expect(current_path).to eq("/shelters/#{shelter.id}")
    expect(page).to have_content('Test Review')
    expect(page).to have_content('Test Review')
    expect(page).to have_content('4')
    expect(page).to have_content('Test Content')
  end

  it 'cant create new review with missing title, rating, or content' do

    shelter = Shelter.create!({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    visit "/shelters/#{shelter.id}"
    click_link "Write Review"
    expect(current_path).to eq("/shelters/#{shelter.id}/reviews/new")

    fill_in('title', with: 'Test Review')
    fill_in('rating', with: '4')
    fill_in('picture', with: 'https://petfbi.org/wp-content/uploads/2012/10/dog-shelter.jpg')

    click_on('Save Review')
    expect(current_path).to eq("/shelters/#{shelter.id}/reviews/new")
    expect(page).to have_content('Content can\'t be blank')
  end
end
