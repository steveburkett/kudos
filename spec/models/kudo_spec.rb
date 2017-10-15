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
  describe 'relations' do
    it { should belong_to(:giver).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
  end

  describe 'validations' do
    subject { FactoryGirl.build(:kudo)  }
    it { should validate_presence_of(:receiver_id) }
    it { should validate_length_of(:text).is_at_most(140) }

    describe 'kudos rules' do
      before { Timecop.freeze( Time.local(2016, 9, 1, 10, 5, 0) ) }
      after { Timecop.return }

      let(:created_at) { Time.now }
      let(:giver1) { FactoryGirl.create(:user) }
      let(:giver2) { FactoryGirl.create(:user) }

      context 'last minute validation' do

        context 'second kudo inside of one a minute for different giver' do
          it 'should pass validation' do
            kudo1 = FactoryGirl.create(:kudo, created_at: created_at - 10.seconds, giver: giver1 )
            kudo2 = FactoryGirl.build(:kudo, created_at: created_at, giver: giver2)
            expect(kudo1).to be_valid
            expect(kudo2).to be_valid
          end
        end

        context 'second kudo inside of one a minute for same giver should be invalid' do
          it 'should fail validation' do
            kudo1 = FactoryGirl.create(:kudo, created_at: created_at - 10.seconds, giver: giver1)
            kudo2 = FactoryGirl.build(:kudo, created_at: created_at, giver: giver1)
            expect(kudo1).to be_valid
            expect(kudo2).to be_invalid
          end
        end

        context 'second kudo outside of one a minute for same giver' do
          it 'should pass validation' do
            kudo1 = FactoryGirl.create(:kudo, created_at: created_at - 2.minutes, giver: giver1)
            kudo2 = FactoryGirl.build(:kudo, created_at: created_at, giver: giver1)
            expect(kudo1).to be_valid
            expect(kudo2).to be_valid
          end
        end
      end
    end
  end
end
