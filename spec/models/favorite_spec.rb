RSpec.describe Favorite do
  describe 'helper methods' do
    before :each do
      @shelter1 = Shelter.create({name: "Shelter 1", address: "1234 NW 10th St.", city: "Gainesville", state: "FL", zip: 32609})
      @pet1 = Pet.create(name: 'Noodle', approx_age: 3, sex: "male", description: "description of noodle", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter1.id )
      @pet2 = Pet.create(name: 'Yoda', approx_age: 4, sex: "male", description: "description of yoda", image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/13001403/Australian-Cattle-Dog-On-White-03.jpg", shelter_id: @shelter1.id)

      @favorite = Favorite.new([])

      @favorite.add_pet(@pet1.id)
      @favorite.add_pet(@pet2.id)
    end

    it 'can add a favorite pet using #add_pet' do
      expect(@favorite.pets).to eq([@pet1.id, @pet2.id])

      @favorite.remove_pet(@pet1.id)
      expect(@favorite.pets).to eq([@pet2.id])
    end

    it 'can find pet objects using #pet_objects' do
      expect(@favorite.pet_objects).to eq([@pet1, @pet2])
    end

    it 'can toggle favorites using #toggle' do
      @favorite.toggle(@pet1.id)
      expect(@favorite.pets).not_to include([@pet1.id])

      @favorite.toggle(@pet1.id)
      expect(@favorite.pets).to include(@pet1.id)
    end
  end
end
