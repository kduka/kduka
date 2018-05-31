Order.create!([

              ])
OrderItem.create!([

                  ])
OrderStatus.create!([
                        {name: "In Progress"},
                        {name: "Placed"},
                        {name: "Shipped"},
                        {name: "Cancelled"},
                        {name: "Pending"}
                    ])
User.create!([
                 #{email: "martindeto@gmail.com", encrypted_password: "$2a$11$a/wd4pEKzIoPj2Wg4FBa4uIEoQJrgW2NBfFxBme.7uXk00EaUQoTe", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 34, current_sign_in_at: "2017-09-13 10:51:17", last_sign_in_at: "2017-08-27 10:19:49", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", callback_url: "http://www.google.com", consumer_key: "631N8K73Vk8giRs+7L4LFLcJlfsI7FC0", consumer_secret: "qh2kfvUbcjgVNyTKCDizSK15D0M=", name: "Martin Ndeto", username: nil},
                 {:name => 'John Doe', :email => 'test@gmail.com', :password => 'spiderpig', :password_confirmation => 'spiderpig', username: nil}
             ])


Store.create!([
                  #{email: "ndeto@gmail.com", encrypted_password: "$2a$11$JkLJW7uoiBpHfxunSe2s/OoC9Vu4lPREZbGCINaz0RInz0SDkuvgS", reset_password_token: "b407668ce6bafed9ef34e19057f9214d2f70f58620a0e4a69d997d08c9398f5d", reset_password_sent_at: "2017-08-27 10:36:49", remember_created_at: nil, sign_in_count: 17, current_sign_in_at: "2017-09-17 18:12:55", last_sign_in_at: "2017-09-14 06:16:10", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", user_id: 1, active: true, username: "mndeto", name: "Ndeto", subdomain: "mndeto", phone: nil, display_email: nil, facebook: "fb.me", instagram: "insta.gram", linkedin: "", twitter: "", pinterest: "", vimeo: "", youtube: "", slogan: "We Deliver!", layout_id: 1, location: "Eastleigh, Nairobi, Kenya", lat: "-1.2731795", lng: "36.8600088"},
                  {:email => 'test@gmail.com', :password => 'spiderpig', :password_confirmation => 'spiderpig', user_id: 1, active: true, username: "mndeto", name: "Test Store", subdomain: "test", phone: "+254725458978", display_email: "test@gmail.com", facebook: "fb.me", instagram: "insta.gram", linkedin: "", twitter: "", pinterest: "", vimeo: "", youtube: "", slogan: "We Deliver!", auto_delivery_location: "Eastleigh, Nairobi, Kenya", lat: "-1.2731795", lng: "36.8600088"}
              ])
Category.create!([
                     {name: "Fruits", active: true, store_id: 1, description: nil},
                     {name: "Vegetables", active: true, store_id: 1, description: "Greens"},
                     {name: "Greens", active: true, store_id: 1, description: "Greens"},

                 ])


SubCategory.create!([
                        {name: "Subcategory", active: false, category_id: 1, description: "Sub"}
                    ])

Product.create!([
                    {name: "Orange", price: "3.9", active: true, store_id: 1, category_id: 1, image: "orange-02.jpg", quantity: 20, sku: "AUETIHRK", description: nil, additional_info: nil, img1: "motd.jpg"},
                    {name: "Cabbage", price: "0.8", active: true, store_id: 1, category_id: 1, image: "cabbage.jpg", quantity: 50, sku: "LYCEHSZJ", description: nil, additional_info: nil, img1: nil},
                    {name: "Banana", price: "0.5", active: true, store_id: 1, category_id: 1, image: "bananasf.jpg", quantity: 100, sku: "CLNSYWPO", description: nil, additional_info: nil, img1: nil},
                    {name: "Apple", price: "0.2", active: true, store_id: 1, category_id: 1, image: "bananasf.jpg", quantity: 23, sku: "JNPXOUHB", description: nil, additional_info: nil, img1: nil},
                    {name: "New", price: "78.0", active: true, store_id: 1, category_id: 1, image: "orange-02.jpg", quantity: 78, sku: "H6FP9TO0", description: nil, additional_info: nil, img1: nil},
                    {name: "Orangey", price: "32.0", active: true, store_id: 1, category_id: 1, image: "orange-02.jpg", quantity: 45, sku: "62MZYS7E", description: nil, additional_info: nil, img1: "bananasf.jpg"},
                ])


Layout.create!([
                   {name: "modern", description: "Modern Theme", d_name: "Modern"},
                   {name: "electronic", description: "Electronic Theme", d_name: "Electronic Store"},
                   {name: "elite", description: "Elite Store", d_name: "Elite Store"},
                   {name: "cstore", description: "CStore Theme", d_name: "Cstore"}
               ])

Store.find(1).update({
                         layout_id: 1
                     })


Admin.create!([
                  {:email => 'martindeto@gmail.com', :password => 'spiderpig', :password_confirmation => 'spiderpig'},
                  {:email => 'jtowett89@gmail.com', :password => 'jupiter89', :password_confirmation => 'jupiter89'}
              ])

Font.create!([
                 {:name => 'Helvetica'},
                 {:name => 'Verdana'},
                 {:name => 'Tahoma'},
                 {:name => 'Times'},
                 {:name => 'Courier'},
                 {:name => 'Arial'},
                 {:name => 'Georgia'},
                 {:name => 'Comic Sans MS'},
                 {:name => 'Bookman'},
                 {:name => 'Garamond'},
             ])

             TransactionStatus.create!([
                 {:status => 'Pending'},
                 {:status => 'Success'},
                 {:status => 'Failed'}
                                       ])


OrderStatus.create!([
                        {name: "Complete"},
                    ])

=begin
Admin.create!([
                  {:email => 'martindeto@gmail.com', :password => 'spiderpig', :password_confirmation => 'spiderpig'}
              ])
=end
