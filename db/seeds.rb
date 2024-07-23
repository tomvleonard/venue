# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

if Rails.env.development? # Only run in development environment!
  unless User.exists?(username: 'admin1')
    admin = User.create(
      username: 'admin1',
      email: 'admin@venue.com',
      password: '!s3crEt',
      password_confirmation: '!s3crEt'
    )
  end

  if Event.count.zero?
    # creates past, present and future events
    [ -60, -30, -20, -5, -1, 0, 1, 5, 20, 30, 60 ].each_with_index do |days, index|
      date = Date.current + days
      Event.create(
        performer: "Performer #{index + 1}",
        when: DateTime.new(date.year, date.month, date.day, 20, 00, 00),
        content: "This is the event content for Performer #{index + 1}"
      )
    end
  end
end
