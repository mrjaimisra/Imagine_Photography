class Seed
  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_customers
    seed.generate_platform_admins
    seed.generate_categories
    seed.generate_stores
    seed.generate_photos
    seed.generate_store_admins
    seed.generate_orders
  end

  def generate_roles
    Role.create!(name: "registered_user")
    Role.create!(name: "store_admin")
    Role.create!(name: "platform_admin")
  end

  def generate_customers
    users.each do |name, email, password, avatar, header|
      User.create!(name: name,
                   email: email,
                   password: password,
                   avatar: File.open("app/assets/images/avatars/#{avatar}.jpg"),
                   header: File.open("app/assets/images/headers/#{header}.jpg")
                  )
      puts "Teacher: #{name} - #{email} created!"
    end

    99.times do |i|
      customer = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Internet.password,
      )

      puts "Customer #{i}: #{customer.name} - #{customer.email} - #{customer.password} created!"
    end
  end

  def generate_platform_admins
    site_admin_role = Role.find_by(name: "platform_admin")
    platform_admin = User.find_by(email: "jorge@turing.io")
    platform_admin.roles << site_admin_role

    puts "Platform Admin #{platform_admin.name} - #{platform_admin.email} - #{platform_admin.password} created!"
  end

  def generate_categories
    categories = ["Travel", "Plants", "Leisure", "People", "Patterns",
                  "Animals", "Architecture", "Sports", "Weddings", "Landscape"]
    10.times do |i|
      name = categories.pop
      category = Category.create!(
        name: name
      )
      puts "Category #{i}: #{category.name} created!"
    end
  end

  def generate_stores
    stores.each do |name, email, avatar, header|
      Store.create!(name:   name,
                    email:  email,
                    avatar: Faker::Company.logo,
                    header: File.open("app/assets/images/headers/#{header}")
                   )
      puts "Photographer: #{name} created!"
    end

    19.times do |i|
      store = Store.create!(
        name:   Faker::Company.name,
        email:  Faker::Internet.email,
        avatar: Faker::Company.logo,
        header: File.open("app/assets/images/headers/header-#{i}.jpg")
      )
      puts "Store #{i}: #{store.name} created!"
    end
  end

  def generate_photos
    50.times do |i|
      10.times do |j|
        photo = Photo.create!(
          name: Faker::Commerce.product_name,
          description: Faker::Lorem.paragraph,
          price: Faker::Commerce.price + 1,
          category_id: j+1,
          store_id: Store.all.sample.id,
          image: File.open("app/assets/images/photos/photo-#{rand(100)}.jpg")
        )
        puts "Photo #{i * 10 + j}: #{photo.name} created!"
      end
    end
  end

  def generate_store_admins
    store_admin_role =  Role.find_by(name: "store_admin")
    admin = User.find_by(email: "andrew@turing.io")
    admin.update_attribute(:store_id, 1)
    admin.roles << store_admin_role

    19.times do |i|
      photographer = User.create!(
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: Faker::Internet.password,
          store_id: i+2
      )
      photographer.roles << store_admin_role
      puts "Photographer #{i}: #{photographer.name} - #{photographer.email} - #{photographer.password} created!"
    end
  end

  def generate_orders
    10.times do |i|
      customers = User.registered_users
      customers.each do |customer|
        order = Order.create!(user_id: customer.id)
        add_photos(order)
        puts "Order #{i}: Order for #{customer.name} created!"
      end
    end
  end

  private

  def add_photos(order)
    10.times do |i|
      photo = Photo.all.sample
      order.photos << photo
      puts "#{i}: Added photo #{photo.name} to order #{photo.id}."
    end
  end

  def users
    [
      ["Josh Cheek",      "josh@turing.io",   "password", "joshc",  "header-1"],
      ["Jeff Casimir",    "jeff@turing.io",   "password", "jeff",   "header-2"],
      ["Jorge Tellez",    "jorge@turing.io",  "password", "jorge",  "header-3"],
      ["Josh Mejia",      "joshm@turing.io",  "password", "joshm",  "header-4"],
      ["Horace Williams", "horace@turing.io", "password", "horace", "header-5"],
      ["Steve Kinney",    "steve@turing.io",  "password", "steve",  "header-6"],
      ["Rachel Warbelow", "rachel@turing.io", "password", "rachel", "header-7"],
      ["Andrew Carmer",   "andrew@turing.io", "password", "andrew", "header-8"],
    ]
  end

  def stores
    [
      ["Linda Snyder",    "linda@snyder.com",      "linda",    "black_and_white_stairs.jpg"],
      ["Danielle Austin", "hello@daphoto.com",     "danielle", "lakeside.jpg"],
      ["Ann Johnson",     "annj@johnsonphoto.com", "ann",      "tansai.jpg"]
    ]
  end
end

Seed.start
