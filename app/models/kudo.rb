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

  validate :kudo_quota, :on => :create

  validates_presence_of :giver_id, :receiver_id
  validates :text, length: { maximum: 140 }

  #these rules for kudos could easily be extended for givers or receivers, or
  #could be managed thru an admin interface and dynamically added to the Kudo model
  def self.last_minute
    where(:created_at => ((Time.zone.now-1.minute)..Time.zone.now))
  end

  def self.last_day
    where(:created_at => ((Time.zone.now-1.day)..Time.zone.now))
  end

  def kudo_quota
    if giver.kudos_given.last_minute.count >= 1
      errors.add(:base, "Exceeds limit of 1 per minute")
    elsif giver.kudos_given.last_day.count >= 10
      errors.add(:base, "Exceeds daily limit of 10")
    end
  end
end
