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

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :kudos_given, class_name: 'Kudo', foreign_key: :giver_id, dependent: :destroy
  has_many :kudos_received, class_name: 'Kudo', foreign_key: :receiver_id

  validates_presence_of :username, :first_name, :last_name

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  #https://github.com/plataformatec/devise/issues/1513
  def remember_me
    true
  end
end
