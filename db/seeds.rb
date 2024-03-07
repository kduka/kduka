Order.create!([])
OrderItem.create!([])

puts "Creating Order Statuses"

# Improvement Ideas
# Fix Seed file to always delete all records before creating new ones?
# Script to do full reset?

OrderStatus.delete_all

OrderStatus.create!(
    [
        {name: "In Progress", status: :in_progress},
        {name: "Placed", status: :placed},
        {name: "Shipped", status: :shipped},
        {name: "Cancelled", status: :cancelled},
        {name: "Pending", status: :pending},
        {name: "Complete", status: :completed}
    ]
)

puts "Creating Users"

User.create!(
    [

        {:name => 'John Doe', :email => 'johndoe@kduka.shop', :password => 'john@doe', :password_confirmation => 'john@doe', username: nil}
    ]
)

puts "Creating Stores"

Store.create!(
    [
        {:email => 'anndoe@kduka.shop', :password => 'ann@doe', :password_confirmation => 'ann@doe', user_id: 1, active: true, username: "anndoe", name: "Test Store", subdomain: "test", phone: "+254725458978", display_email: "testa@kduka.shop", facebook: "fb.me", instagram: "insta.gram", linkedin: "", twitter: "", pinterest: "", vimeo: "", youtube: "", slogan: "We Deliver!", auto_delivery_location: "Eastleigh, Nairobi, Kenya", lat: "-1.2731795", lng: "36.8600088", c_subdomain: 'www', domain: 'test.localhost', own_domain: true, active: true }
    ]
)

puts "Creating Categories"

Category.create!(
    [
        {name: "Fruits", active: true, store_id: Store.first.id, description: nil},
        {name: "Vegetables", active: true, store_id: Store.first.id, description: "Greens"},
        {name: "Greens", active: true, store_id: Store.first.id, description: "Greens"},

    ]
)

puts "Creating Subcategories"

SubCategory.create!(
    [
        {name: "Subcategory", active: false, category_id: Category.first.id, description: "Sub"}
    ]
)

puts "Creating Products"

Product.create!(
    [
        {name: "Orange", price: "3.9", active: true, store_id: Store.first.id, category_id: Category.first.id, image: "orange-02.jpg", quantity: 20, sku: "AUETIHRK", description: nil, additional_info: nil, img1: "motd.jpg"},
        {name: "Cabbage", price: "0.8", active: true, store_id: Store.first.id, category_id: Category.first.id, image: "cabbage.jpg", quantity: 50, sku: "LYCEHSZJ", description: nil, additional_info: nil, img1: nil},
        {name: "Banana", price: "0.5", active: true, store_id: Store.first.id, category_id: Category.first.id, image: "bananasf.jpg", quantity: 100, sku: "CLNSYWPO", description: nil, additional_info: nil, img1: nil},
        {name: "Apple", price: "0.2", active: true, store_id: Store.first.id, category_id: Category.first.id, image: "bananasf.jpg", quantity: 23, sku: "JNPXOUHB", description: nil, additional_info: nil, img1: nil},
        {name: "New", price: "78.0", active: true, store_id: Store.first.id, category_id: Category.first.id, image: "orange-02.jpg", quantity: 78, sku: "H6FP9TO0", description: nil, additional_info: nil, img1: nil},
        {name: "Orangey", price: "32.0", active: true, store_id: Store.first.id, category_id: Category.first.id, image: "orange-02.jpg", quantity: 45, sku: "62MZYS7E", description: nil, additional_info: nil, img1: "bananasf.jpg"},
    ]
)

puts "Creating Product Variants"

Layout.create!(
    [
        {name: "modern", description: "Modern Theme", d_name: "Modern"},
        {name: "electronic", description: "Electronic Theme", d_name: "Electronic Store"},
        {name: "elite", description: "Elite Store", d_name: "Elite Store"},
        {name: "cstore", description: "CStore Theme", d_name: "Cstore"}
    ]
)

puts "Updating Store Layout"

Store.find(1).update({layout_id: Layout.first.id})

puts "Creating Admins"

Admin.create!(
    [
        {:email => 'superadmin@kduka.shop', :password => 'kduka_admin', :password_confirmation => 'kduka_admin'},
    ]
)

puts "Creating Transaction Statuses"

TransactionStatus.create!(
    [
      {:status => 'Pending'},
      {:status => 'Success'},
      {:status => 'Failed'}
    ]
)

puts "Creating Fonts"

Font.create!(
    [
        {:name => 'Abril Fatface'},
        {:name => 'Amatic SC'},
        {:name => 'Anton'},
        {:name => 'Comfortaa'},
        {:name => 'Concert One'},
        {:name => 'Cormorant Garamond'},
        {:name => 'Courgette'},
        {:name => 'Crimson Text'},
        {:name => 'Dancing Script'},
        {:name => 'Dokdo'},
        {:name => 'Fascinate Inline'},
        {:name => 'Fjalla One'},
        {:name => 'Gloria Hallelujah'},
        {:name => 'Great Vibes'},
        {:name => 'Inconsolata'},
        {:name => 'Indie Flower'},
        {:name => 'Josefin Sans'},
        {:name => 'Lobster'},
        {:name => 'Merienda'},
        {:name => 'Merriweather'},
        {:name => 'Mrs Sheppards'},
        {:name => 'Mukta'},
        {:name => 'Nanum Gothic'},
        {:name => 'Noto Serif'},
        {:name => 'Open Sans Condensed:300'},
        {:name => 'Orbitron'},
        {:name => 'PT Sans Narrow'},
        {:name => 'Pacifico'},
        {:name => 'Play'},
        {:name => 'Playfair Display'},
        {:name => 'Rajdhani'},
        {:name => 'Righteous'},
        {:name => 'Roboto Slab'},
        {:name => 'Satisfy'},
        {:name => 'Shadows Into Light'},
        {:name => 'Source Serif Pro'},
        {:name => 'Sree Krushnadevaraya'},
        {:name => 'Titillium Web'},
        {:name => 'Yanone Kaffeesatz'},
        {:name => 'ZCOOL XiaoWei'},
        {:name => 'Helvetica'},
        {:name => 'Verdana'},
        {:name => 'Tahoma'},
        {:name => 'Times'},
        {:name => 'Courier'},
        {:name => 'Arial'},
        {:name => 'Georgia'},
        {:name => 'Comic Sans MS'},
        {:name => 'Bookman'},
        {:name => 'Garamond'}
    ]
)

puts "Creating Plans"

Plan.create!(
    [
        {:name => 'basic',:amount => '200'},
        {:name => 'premium',:amount => '420'},
    ]
)