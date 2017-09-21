=begin
  Category.create!([
  {name: "Fruits", active: true, store_id: 1, description: nil},
  {name: "Vegetables", active: true, store_id: 1, description: "Greens"}
])
Product.create!([
  {name: "Banana", price: "0.49", active: true, store_id: nil, category_id: nil},
  {name: "Apple", price: "0.29", active: true, store_id: nil, category_id: nil},
  {name: "Carton of Strawberries", price: "1.99", active: true, store_id: nil, category_id: nil},
  {name: "Chicken", price: "5.2", active: true, store_id: 1, category_id: nil},
  {name: "Orange", price: "2.1", active: true, store_id: 1, category_id: nil},
  {name: "Ngombe", price: "52.0", active: true, store_id: 1, category_id: nil},
  {name: "Cabbage", price: "2.3", active: true, store_id: 2, category_id: nil},
  {name: "Kale", price: "3.3", active: true, store_id: 2, category_id: nil},
  {name: "Tomatoes", price: "4.5", active: true, store_id: 2, category_id: nil},
  {name: "my product", price: "20000.0", active: true, store_id: 4, category_id: nil},
  {name: "test 2", price: "5000.0", active: true, store_id: 4, category_id: nil}
])
=end

Layout.create!([
  #{name: "modern", description: "Modern Theme", d_name:"Modern Theme"},
  # {name: "electronic", description: "Electronic Theme", d_name:"Electronic Theme"},
  # {name: "bigstore", description: "Big Store Theme", d_name:"Big Store Theme"}
  {name: "elite", description: "Elite Theme", d_name:"Elite Theme"}
])
