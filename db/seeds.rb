User.create!(name:  "admin",
             email: "pigaru.gooood.mar19@gmail.com",
             password:              "adminadmin",
             password_confirmation: "adminadmin",
             admin: true)

15.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end