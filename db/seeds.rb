# coding: utf-8

User.create!( name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              )
              
99.times do |n|
  name = Faker::Name.name
  email = "sample#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end             

50.times do |i|
  50.times do |n|
    title = "タスク#{n+1}"
    content = "詳細#{n+1}"
    Task.create!(title: title,
                 content: content,
                 user_id: i+1,
                )
  end
end