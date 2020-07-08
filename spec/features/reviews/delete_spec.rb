RSpec.describe "destroy existing review", type: :feature do
  it "uses 'delete review' link to delete given review, and redirects to shelter show page" do

    shelter = Shelter.create!({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
    review = shelter.reviews.create!({title: "Best place ever!", rating: 5, content: "Love my Doggo!", picture: "https://post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg"})

    visit "/shelters/#{shelter.id}"
    expect(page).to have_content('Best place ever!')

    click_on "Delete Review"
    expect(current_path).to eq("/shelters/#{shelter.id}")

    expect(page).to_not have_content('Best place ever!')
  end
end
