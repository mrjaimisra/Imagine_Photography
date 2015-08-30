def build_categories
  categories = ["Travel", "Plants", "Leisure", "People", "Patterns",
                "Animals", "Architecture", "Sports", "Weddings",
                "Landscape"]

  categories.each do |category|
    Category.create(name: category)
  end
end
