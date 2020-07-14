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
end
