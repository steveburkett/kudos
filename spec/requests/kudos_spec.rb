require 'rails_helper'

RSpec.describe 'Kudos API', type: :request do 
  describe 'GET /kudos' do 
    let!(:receiving_user) { create(:user) }
    let!(:giving_user) { create(:user) }

    let!(:kudos) do
      create_list(:kudo, 5, 
        giver: giving_user,
        receiver: User.first
      )
    end

    before { get '/kudos' }

    it 'returns all kudos for currently logged in user' do 
      response_body = JSON.parse(response.body)

      expect(response_body).not_to be_empty
      expect(response_body.size).to eq(5)
    end

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:user_id/kudos' do
    let!(:giving_user) { create(:user) }
    let!(:receiving_user) { create(:user) }
    let(:user_id) { receiving_user.id }

    let!(:kudos) do
      create_list(:kudo, 5, 
        giver: giving_user,
        receiver: receiving_user
      )
    end

    before { get "/users/#{user_id}/kudos" }

    context "when the user id is valid" do 
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns kudos given to the user' do 
        expect(JSON.parse(response.body).size).to eq(5)
      end
    end

    context "when the user id is not valid" do 
      let(:user_id) { 0 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do 
        expect(response.body).to match(/Couldn't find User/)
      end
    end

  end

  describe 'POST /kudos' do 
    let(:text) { Faker::Matz.quote[0..139] }
    let!(:giving_user) { create(:user) }
    let!(:receiving_user) { create(:user) }

    context 'with a valid request' do 
      let(:valid_params) do 
        {
          text: text,
          giver_id: giving_user.id,
          receiver_id: receiving_user.id
        }
      end

      before { post '/kudos', params: valid_params } 

      it 'creates a kudo' do 
        expect(JSON.parse(response.body)['text']).to eq(text)

        should { change(Kudo, :count).by(1) } 
      end

      it 'returns status code 201' do 
        expect(response).to have_http_status(201)
      end
    end

    context 'with an invalid request' do 
      let(:invalid_params) { { text: text } }

      before { post '/kudos', params: invalid_params } 

      it 'returns status code 422' do 
        expect(response).to have_http_status(422)
      end

      it 'returns error message' do 
        expect(response.body).to match(/Giver can't be blank/)
        expect(response.body).to match(/Receiver can't be blank/)
      end
    end
  end

  describe 'DELETE /kudos/:id' do 
    let(:kudo_id) { create(:kudo).id }
    before { delete "/kudos/#{kudo_id}" }

    it 'returns status code 204' do 
      expect(response).to have_http_status(204)
    end

    it 'deletes the kudo' do 
      should { change(Kudo, :count).by(1) } 
    end
  end
end