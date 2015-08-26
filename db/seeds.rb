class Seed
  def self.start
    seed = Seed.new
    seed.generate_customers
    seed.generate_photographers
    seed.generate_platform_admins
    seed.generate_photos
    seed.generate_categories
    seed.generate_orders
  end
  
  def generate_photos
    500.times do |i|
      photo = Photo.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph,
          image_url: "http://robohash.org/#{i}.png?set=set2&bgset=bg1&size=200x200"
      )

<<<<<<< HEAD
  def run
    create_categories
    create_photos
    create_statuses
=======
      puts "Photo #{i}: #{photo.name} created!"
    end
>>>>>>> master
  end

  def generate_categories
    10.times do |i|
      categories = %w(Travel Plants Leisure People Patterns Animals Black_And_White Sports Weddings Landscape)
      name = categories.shuffle.pop
      category = Category.create!(
          name: name
      )
      categorize_photos(category)
      puts "Category #{i}: #{category.name} created!"
    end
  end

  def generate_customers
    User.create(name: "Josh",
                email: "josh@turing.io",
                password: "password",
                role: 0
    )

    99.times do |i|
      customer = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          role: 0,
          password: Faker::Internet.password,
      )
      puts "Customer #{i}: #{customer.name} - #{customer.email} - #{customer.password} created!"
    end
  end

<<<<<<< HEAD
  def create_photos
    id = %w(1 2 3)
    price = %w(3 5 7 9 11 13 15)
    [*1...15].each do |num|
      Photo.create(name: name.rotate(num).first,
                  description: description,
                  price: price.rotate(num).first,
                  image_url: image_url,
                  category_id: id.rotate(num).first)
=======
  def generate_photographers
    admin = User.create!(
        name: Carmer,
        email: "andrew@turing.io",
        password: "password",
        role: 2
    )
        admin.update_attribute(business_id, admin.id)

    19.times do |i|
      photographer = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          role: 2,
          password: Faker::Internet.password
    )
        photographer.update_attribute(business_id, photographer.id)

      puts "Photographer #{i}: #{photographer.name} - #{photographer.email} - #{photographer.password} created!"
>>>>>>> master
    end
  end

  # def generate_business_admins
  #     business_admin = User.create!(
  #         name: Faker::Name.name,
  #         email: andrew@turing.io,
  #         role: 1,
  #         password: "password",
  #     )
  #
  #     puts "Business Admin #{i}: #{business_admin.name} - #{business_admin.email} - #{business_admin.password} created!"
  # end

  def generate_platform_admins
    platform_admin = User.create!(
        name: "Jorge",
        email: "jorge @turing.io",
                     role: 3,
                     password: "password",
    )

    puts "Platform Admin #{i}: #{platform_admin.name} - #{platform_admin.email} - #{platform_admin.password} created!"
  end

  def generate_orders
    10.times do |i|
      customers = User.where(role: 0)
      customers.each do |customer|
        order = Order.create!(user_id: customer.id)
      end
      add_photos(order)
      puts "Order #{i}: Order for #{user.name} created!"
    end
  end

  private

  def add_photos(order)
    10.times do |i|
      photo = Photo.find(Random.new.rand(1..500))
      order.photos << photo
      puts "#{i}: Added photo #{photo.name} to order #{photo.id}."
    end
  end

  def categorize_photos(category)
    50.times do |i|
      photo = Photo.find(Random.new.rand(1..500))
      category.photos << photo
      puts "#{i}: Added photo #{photo.name} to category #{category.name}."
    end
  end
end

Seed.start