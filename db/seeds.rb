class Seed
  attr_reader :seed
  def initialize
    @seed
  end

  def run
    create_categories
    create_items
    create_statuses
  end

  def create_categories
    names = %w(breakfast lunch dinner)
    [*0..2].each do |num|
      Category.create(name: names[num])
    end
  end

  def create_statuses
    names = %w(ordered paid cancelled completed)
    [*0..3].each do |num|
      Status.create(name: names[num])
    end
  end

  def create_items
    id = %w(1 2 3)
    price = %w(3 5 7 9 11 13 15)
    [*1...15].each do |num|
      Item.create(name: name.rotate(num).first,
                  description: description,
                  price: price.rotate(num).first,
                  image_url: image_url,
                  category_id: id.rotate(num).first)
    end
  end

  def name
    %w(Pizza Hamburger Hotdog Chilli Hummus Vanilla Corn Beans Steak Rice Olives Soup Lentils Fish Tofu)
  end

  def description
    "Very tasty."
  end

  def image_url
    "http://i.livescience.com/images/i/000/048/850/i02/capybara-02.jpg?1324347800"
  end
end

seed = Seed.new
seed.run
