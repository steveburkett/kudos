require 'faker'

def generate_user_data
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.user_name("#{first_name} #{last_name}", '_')
  
  return { first_name: first_name, last_name: last_name, username: username }
end

def limited_text(sentence)
  return sentence[0..139]
end

# first user is the "logged in" user accessed with GET /users/me
user1 = User.create!(generate_user_data.merge({ created_at: 5.months.ago }))
user2 = User.create!(generate_user_data.merge({ created_at: 4.months.ago }))
user3 = User.create!(generate_user_data.merge({ created_at: 3.months.ago }))
user4 = User.create!(generate_user_data.merge({ created_at: 2.months.ago }))
user5 = User.create!(generate_user_data)
user6 = User.create!(generate_user_data)

Kudo.create!({ giver: user1, receiver: user2, created_at: 3.months.ago, text: limited_text(Faker::Hacker.say_something_smart) })
Kudo.create!({ giver: user1, receiver: user2, created_at: 12.days.ago, text: limited_text(Faker::RickAndMorty.quote) })
Kudo.create!({ giver: user1, receiver: user4, created_at: 1.week.ago, text: limited_text(Faker::Coffee.notes) })
Kudo.create!({ giver: user1, receiver: user5, created_at: 4.hours.ago, text: limited_text(Faker::DrWho.catch_phrase) })
Kudo.create!({ giver: user1, receiver: user2, created_at: 1.month.ago, text: limited_text(Faker::Lovecraft.sentence) })
Kudo.create!({ giver: user1, receiver: user5, created_at: 16.hours.ago, text: limited_text(Faker::Lovecraft.sentence) })
Kudo.create!({ giver: user1, receiver: user2, created_at: 1.week.ago, text: limited_text(Faker::MostInterestingManInTheWorld.quote) })
Kudo.create!({ giver: user2, receiver: user1, created_at: 2.hours.ago, text: limited_text(Faker::StarWars.quote) })
Kudo.create!({ giver: user2, receiver: user1, created_at: 22.hours.ago, text: limited_text(Faker::Lovecraft.sentence) })
Kudo.create!({ giver: user2, receiver: user3, created_at: 3.weeks.ago, text: limited_text(Faker::HitchhikersGuideToTheGalaxy.quote) })
Kudo.create!({ giver: user3, receiver: user1, created_at: 4.months.ago, text: limited_text(Faker::TwinPeaks.quote) })
Kudo.create!({ giver: user3, receiver: user4, created_at: 2.weeks.ago, text: limited_text(Faker::Matz.quote) })
Kudo.create!({ giver: user3, receiver: user2, created_at: 6.days.ago, text: limited_text(Faker::RickAndMorty.quote) })
Kudo.create!({ giver: user3, receiver: user2, created_at: 3.weeks.ago, text: limited_text(Faker::Overwatch.quote) })
Kudo.create!({ giver: user3, receiver: user4, created_at: 1.weeks.ago, text: limited_text(Faker::Matz.quote) })
Kudo.create!({ giver: user5, receiver: user2, text: limited_text(Faker::RickAndMorty.quote) })
Kudo.create!({ giver: user5, receiver: user2, text: limited_text(Faker::Simpsons.quote) })
Kudo.create!({ giver: user5, receiver: user2, text: limited_text(Faker::HarryPotter.quote) })
Kudo.create!({ giver: user6, receiver: user2, text: limited_text(Faker::WorldOfWarcraft.quote) })
Kudo.create!({ giver: user6, receiver: user5, text: limited_text(Faker::HarryPotter.quote) })