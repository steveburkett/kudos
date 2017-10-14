# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string
#  kudos_given_count    :integer
#  kudos_received_count :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  first_name           :text
#  last_name            :text
#
#
FactoryGirl.define do 
  factory :user do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::GameOfThrones.dragon }
  end
end
