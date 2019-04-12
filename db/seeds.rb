# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.destroy_all
Track.destroy_all
Tag.destroy_all
TrackTag.destroy_all

admin_user = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
track = Track.create!(title: 'imperial march', admin_user_id: admin_user.id, audio: '/musicFS/imperial_march.mp3') if Rails.env.development?
tag = Tag.create!(genre: 'Orchestral') if Rails.env.development?
TrackTag.create!(track_id: track.id, tag_id: tag.id) if Rails.env.development?