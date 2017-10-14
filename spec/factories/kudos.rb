# == Schema Information
#
# Table name: kudos
#
#  id          :integer          not null, primary key
#  giver_id    :integer
#  receiver_id :integer
#  text        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do 
  factory :kudo do 
    text { Faker::HitchhikersGuideToTheGalaxy.quote[0..139] }
    association :giver, factory: :user
    association :receiver, factory: :user
  end
end
