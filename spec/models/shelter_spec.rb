RSpec.describe Shelter do
  describe 'validatons' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }

  end

  describe 'relationships' do
    it { should have_many :pets }
  end

  describe 'helper methods' do
    before :each do
      @shelter2 = Shelter.create({name: "Shelter 2", address: "1234 Main St.", city: "Denver", state: "CO", zip: 80218})
      @shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
      @review1 = Review.create({title: "My great experience!", rating: 5, content: "I went here and loved it.", picture: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg", shelter_id: @shelter1.id})
      @review2 = Review.create({title: "My terrible experience!", rating: 0, content: "I went here and hated it.", picture: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg", shelter_id: @shelter1.id})
      @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter1.id )
      @pet2 = Pet.create(name: 'Yoda', approx_age: 4, sex: "male", description: "description of yoda", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter2.id)
      @pet3 = Pet.create(name: 'Dogoo', approx_age: 5, sex: "female", description: "description of doggo", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter2.id)
      @application1 = Application.create(name: 'Timmy', address: '123 Street St.', city: 'Denver', state: 'CO', zip: '80218', phone_number: '303-123-4567', reason: 'Because I love animals!')
      ApplicationPet.create(application_id: @application1.id, pet_id: @pet1.id)
    end

    it 'uses #num_of_pets to total pets per shelter' do
      expect(@shelter1.num_of_pets).to eq(1)
    end

    it 'uses #average_rating to calculate average rating' do
      expect(@shelter1.average_rating).to eq(2.5)
      expect(@shelter2.average_rating).to eq(0)
    end

    it 'uses #num_of_applications to count total number of applications' do
      expect(@shelter1.num_of_applications).to eq(1)
    end

    it 'uses #sort_alphabetically to present shelters alphabetically' do
      expect(Shelter.sort_alphabetically).to eq([@shelter1, @shelter2])
    end

    it 'uses #sort_pet_count to list shelters by pet count' do
      expect(Shelter.sort_pet_count).to eq([@shelter2, @shelter1])
    end
  end
end
