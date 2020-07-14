RSpec.describe "update an existing review", type: :feature do
  it "uses 'edit shelter' to update the reviews title, rating, content, image" do

  shelter = Shelter.create!({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
  review = shelter.reviews.create!({title: "Best place ever!", rating: 5, content: "Love my Doggo!", picture: "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg"})

  visit "/shelters/#{shelter.id}"

  within('#reviews') do
    click_on "Edit"
  end

  expect(current_path).to eq("/reviews/#{review.id}/edit")

  fill_in('title', with: 'Updated Review')
  select "5", :from => "rating"
  fill_in('content', with: 'This place rocks!')
  fill_in('picture', with: 'https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg')

  click_on('Save')

  expect(current_path).to eq("/shelters/#{shelter.id}")
  end
end
