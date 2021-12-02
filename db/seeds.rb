User.create!(name: "Tran Hai",
             email: "tranhai@gmail.com",
             phone: Faker::Number.leading_zero_number(digits: 10),
             password: "123456",
             password_confirmation: "123456",
             role: 1,
             activated: true,
             activated_at: Time.zone.now)
50.times do |n|
  name = Faker::Name.name
  email = "tranhai-#{n+1}@gmail.com"
  password = "password"
  phone = Faker::Number.leading_zero_number(digits: 10)
  User.create!(name: name, 
               email: email,
               phone: phone,
               password: password, 
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
6.times do |n|
  field_name = "Sân bóng #{n+1}"
  SoccerField.create!(field_name: field_name,
                      type_field: 1,
                      price: 1000000,
                      status: 1,
                      address: "Hòa Vang")
end
