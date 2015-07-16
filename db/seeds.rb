# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
products =[
  {name: "Goat Argyle Sweater", price: "30", description:"Pink and Brown Argyle Sweater. Hand Knit by bored housewives. Best for Goat Kids under the age of 1.", stock: "3", photo_url: "goatsweater.jpg", user_id: "1", category_id: "1"
  },
  {name: "Cat Ushanka", price: "25", description: "Only the very best for the Russian Cat Czar that rules your roost at home!", stock: "2", photo_url: "catushanka.jpg", user_id: "2", category_id: "2"
  },
  {name: "French Beret Cat ", price: "35", description:"Handstiched and imported from France, only for the fanciest of felines.", stock: "1", photo_url: "catberet.jpg", user_id: "2", category_id: "2"
  },
  {name: "Dog Clogs", price: "40", description:"Frog clogs for you Doggy Dog", stock: "2", photo_url: "dogfrogclog.jpg", user_id: "3", category_id: "3"
  }
]

products.each do |product|
  Product.create product
end

users = [
  {username: "GoatMercantile", password_digest: "goat4ever", email: "fancygoatcoats@gmail.com"
  },
  {username: "CatHabberdat", password_digest: "felinefurever", email: "catinthehat@gmail.com"
  },
  {username: "DapperDoggy", password_digest: "mycutedog", email: "dogsinclogs@gmail.com"
  }
]

users.each do |user|
  User.create user
end

categories =[
  {name: "Goats In Coats"},
  {name: "Cat in Hats"},
  {name: "Dogs in Clogs"}
]

categories.each do |category|
  Category.create category
end
