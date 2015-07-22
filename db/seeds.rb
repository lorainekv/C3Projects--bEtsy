# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
products =[
  {name: "Goat Argyle Sweater", price: "30", description:"Pink and Brown Argyle Sweater. Hand Knit by bored housewives. Best for Goat Kids under the age of 1.", stock: "3", photo_url: "goatsweater.jpg", user_id: "1",
  },

  {name: "Goat Safety Vest", price: "25", description:"For the working goat eating the fields to the helpful roadside assistance goat, this safety vest is essential for increasing visibility and safety of your goat. Would also be required for any Village Goat Group Member for genuine authenticity.", stock: "4", photo_url: "safetyvestgoat.jpg", user_id: "1"
  },

  {name: "Goat Red Flannel", price: "30", description:"Thanks to the Grunge movement that never seemed to die, there's never been a wider assortment of flannel available for all goats. This jewel is the classic Red that will surely stand out in a crowd and set your goat up for their next journey whether around the world with their band, or around the farm.", stock: "2", photo_url: "goatinflannel.jpg", user_id: "1"
  },

  {name: "Cat Ushanka", price: "25", description: "Only the very best for the Russian Cat Czar that rules your roost at home!", stock: "2", photo_url: "catushanka.jpg", user_id: "2"
  },
  {name: "French Beret Cat ", price: "35", description:"Handstiched and imported from France, only for the fanciest of felines.", stock: "1", photo_url: "catberet.jpg", user_id: "2"
  },

  {name: "Afternoon Tea Hat Cat ", price: "30", description:"High noon cup of tea is served purrrrrrfectly alongside this beautifully crafted and delicate hat for your highly sophisticated and highly discerning kitty. ", stock: "2", photo_url: "teahatcat.jpg", user_id: "2"
  },

  {name: "Cat Attack Hat ", price: "35", description:"For the Cat with a sense of humor. This hat will make it look like your precious is about to be snatched up by the jaws of life...or another animal that resembles a fish. It's eat or be eaten in the cruel kitty world we live in sometimes.", stock: "2", photo_url: "fishmouthhat.png", user_id: "2"
  },

  {name: "Dog Clogs", price: "40", description:"Frog clogs for you Doggy Dog", stock: "2", photo_url: "dogfrogclog.jpg", user_id: "3"
  },

  {name: "Dog Sneakers", price: "36", description:"When you're in the mood for a throwback to the classic chucks look, only these will suffice! Black soles with white detailing and laces complete the look that will have everyone knowing your dog is keeping it fresh!", stock: "2", photo_url: "pomsneakers.jpg", user_id: "3"
  },

  {name: "Blue and Black Dog Boots", price: "40", description:"Understated timelessness is what you get with our classic black and blue dog booties. Ready for everyday wear, these booties will stand the test of time and provide you and your loveable canine, years of use and protection.", stock: "2", photo_url: "lassiesbooties.jpg", user_id: "3"
  },

  {name: "Maryjanes for your Dog ", price: "30", description:"Get the look of Maryjanes without the pain of the heels! These beautifully crafted dog booties give the look of the classic shoe with delicate straps and colorful accent pops of color, all without the painful wedge heel. Your dog will not be disappointed and their legs will look elongated as a bonus!", stock: "3", photo_url: "dogsocks.jpg", user_id: "3"
  },
]

products.each do |product|
  Product.create product
end

users = [
  {username: "Goat Mercantile", password_digest: "goat4ever", email: "fancygoatcoats@gmail.com"
  },
  {username: "Cat Habberdat", password_digest: "felinefurever", email: "catinthehat@gmail.com"
  },
  {username: "Dapper Doggy", password_digest: "mycutedog", email: "dogsinclogs@gmail.com"
  }
]

users.each do |user|
  User.create user
end

categories =[
  {name: "Goats In Coats"},
  {name: "Cat In Hats"},
  {name: "Dogs In Clogs"}
]

categories.each do |category|
  Category.create category
end

products_categories = {
  1 => [1, 2, 3],
  2 => [4, 5, 6, 7],
  3 => [8, 9, 10, 11]
}

category = Category.find(1)
category.products << Product.find(1)
category.products << Product.find(2)
category.products << Product.find(3)

category = Category.find(2)
category.products << Product.find(4)
category.products << Product.find(5)
category.products << Product.find(6)
category.products << Product.find(7)

category = Category.find(3)
category.products << Product.find(8)
category.products << Product.find(9)
category.products << Product.find(10)
category.products << Product.find(11)


# products_categories.each do |k, v|
#   category = Category.find(k)
#   products_categories.each do |v|
#     category.product << Product.find(v)
#   end

