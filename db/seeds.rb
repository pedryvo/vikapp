# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

10.times do
  Company.find_or_create_by!(
    name: Faker::Company.name
  )
end

Admin.create!(
    email: 'admin@admin.com',
    password: 'admin123',
    password_confirmation: 'admin123'
  )

10.times do
  Admin.create!(
    email: Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
  )
end

Admin.all.each do |admin|
  Company.all.each do |company|
    Invite.find_or_create_by!(
      admin: admin,
      company: company
    )
  end
end

Invite.last(2).first.update(deactivated_at: 1.month.from_now)
Invite.last.update(deactivated_at: 2.month.from_now)
