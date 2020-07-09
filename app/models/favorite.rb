class Favorite
  attr_reader :pets

  def initialize(pet_list)
    @pets = pet_list || []
  end

  def add_pet(id)
    @pets << id
  end

  def remove_pet(id)
    @pets.delete(id)
  end
end
