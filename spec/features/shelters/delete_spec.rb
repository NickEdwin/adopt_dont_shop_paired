RSpec.describe "destroy existing shelter", type: :feature do
  it "uses 'delete shelter' link to delete given shelter, and redirect to index" do

    shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})

    visit "/shelters/#{shelter1.id}"
    click_on "Delete"
    expect(current_path).to eq("/shelters")

    expect(page).to_not have_content('Shelter 1')
  end
end
