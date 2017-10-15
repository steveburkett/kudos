require 'rails_helper'

RSpec.describe 'Kudos API', type: :request do

  def login
    user = FactoryGirl.create(:user)

    sign_in user
    get authenticated_root_path
    expect(controller.current_user).to eq(user)
  end

  def logout
    sign_out user
    get authenticated_root_path
    expect(controller.current_user).to be_nil
  end

  describe 'logged out' do
    it 'returns unauthenticated' do
      get '/kudos'
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET /kudos' do 
    let!(:receiving_user) { create(:user) }
    let!(:giving_user) { create(:user) }

    let!(:kudos) do
      create(:kudo, giver: giving_user, receiver: User.first)
    end

    it 'shows the kudos form' do
      login
      get '/kudos'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /kudos' do
    let(:text) { Faker::Matz.quote[0..139] }
    let!(:giving_user) { create(:user) }
    let!(:receiving_user) { create(:user) }

    context 'with a valid request' do
      let(:valid_params) do
        {
            kudo: {
              text: text,
              giver_id: giving_user.id,
              receiver_id: receiving_user.id
          }
        }
      end

      it 'creates a kudo' do
        login
        expect { post '/kudos', params: valid_params}.to change(Kudo, :count).by(1)
      end
    end
  end
end