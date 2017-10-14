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

class Kudo < ApplicationRecord
  belongs_to :giver, class_name: 'User', counter_cache: :kudos_given_count, inverse_of: :kudos_given
  belongs_to :receiver, class_name: 'User', counter_cache: :kudos_received_count, inverse_of: :kudos_received

  validates_presence_of :giver_id, :receiver_id
  validates :text, length: { maximum: 140 }
end
