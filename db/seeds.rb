def calFactor booking_used
  case booking_used
    when "05:00","06:00","07:00","08:00","09:00",
      "10:00","11:00","12:00","13:00","14:00",
      "15:00","16:00"
      return 2
    when "17:00","18:00","19:00"
      return 3
    else
      return 4
  end
end
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
60.times do |n|
  field_name = "Sân bóng #{n+1}"
  SoccerField.create!(field_name: field_name,
                      type_field: 1,
                      price: 1000000,
                      status: 1,
                      address: "Hòa Vang")
end
# 1.times do |n|
#   times = ["05:00","06:00","07:00","08:00","09:00",
#           "10:00","11:00","12:00","13:00","14:00",
#           "15:00","16:00","17:00","18:00","19:00",
#           "20:00","21:00","22:00","23:00"]
#   current_price = 80000
#   ids = SoccerField.limit(20).pluck(:id)
#   ids.each do |id|
#     times.each do |booking_used|
#       order_details.create!(
#         soccer_field_id: id,
#         booking_used: booking_used,
#         current_price: current_price*calFactor(booking_used))
#     end
#   end
# end
