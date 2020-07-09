RSpec.describe Favorite do
  describe '#add_pet' do
    it 'can add a favorite pet' do

      pet1 = 1
      pet2 = 2
      favorite = Favorite.new([])

      favorite.add_pet(1)
      favorite.add_pet(2)

      expect(favorite.pets).to eq([1, 2])
    end
  end
end
