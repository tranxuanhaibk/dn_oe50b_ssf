User.create!(name: "Tran Hai",
             email: "tranhai@gmail.com",
             phone: Faker::Number.leading_zero_number(digits: 10),
             password: "123456",
             password_confirmation: "123456",
             role: 1,
             confirmed_at: Time.zone.now)
30.times do |n|
  name = Faker::Name.name
  email = "tranhai-#{n+1}@gmail.com"
  password = "password"
  phone = Faker::Number.leading_zero_number(digits: 10)
  User.create!(name: name, 
               email: email,
               phone: phone,
               password: password, 
               password_confirmation: password,
               role: 0,
               confirmed_at: Time.zone.now,
               created_at: rand(2.years).seconds.ago)
end
10.times do |n|
  field_name = "Sân bóng #{n+1}"
  SoccerField.create!(field_name: field_name,
                      type_field: 1,
                      price: 100000,
                      status: 1,
                      description: "Sân bóng có địa chỉ tại: 54 Liên Chiểu SĐT: 0865787769 
                       Vui lòng đặt sớm để giữ sân !")
end
