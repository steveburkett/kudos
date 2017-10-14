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

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:kudos_received) }
  it { should have_many(:kudos_given).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
end
