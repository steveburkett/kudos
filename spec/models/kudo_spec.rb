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

require 'rails_helper'

RSpec.describe Kudo, type: :model do
  it { should belong_to(:giver).class_name('User') }
  it { should belong_to(:receiver).class_name('User') }

  it { should validate_presence_of(:giver_id) }
  it { should validate_presence_of(:receiver_id) }
  it { should validate_length_of(:text).is_at_most(140) }
end
