require 'rails_helper'

RSpec.describe 'Users API', type: :request do 
  let!(:users) { create_list(:user, 5) }
  let(:user_id) { users.first.id } 

  describe 'GET /users' do 
    before { get '/users' } 

    it 'returns all users' do 
      response_body = JSON.parse(response.body)

      expect(response_body).not_to be_empty
      expect(response_body.size).to eq(5)
    end

    it 'returns status code 200' do 
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do 
    before { get "/users/#{user_id}" }

    context 'when the record exists' do 
      it 'returns the record' do 
        response_body = JSON.parse(response.body)

        expect(response_body).not_to be_empty
        expect(response_body['id']).to eq(user_id)
      end

      it 'returns status code 200' do 
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do 
      let(:user_id) { 206 }

      it 'returns status code 404' do 
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do 
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'POST /users' do 
    let(:first_name) { Faker::GameOfThrones.dragon }
    let(:last_name) { Faker::GameOfThrones.dragon }
    let(:username) { first_name + last_name }

    context 'with a valid request' do 
      let(:valid_params) do
        { 
          username: username,
          first_name: first_name,
          last_name: last_name
        }
      end

      before { post '/users', params: valid_params } 

      it 'creates a user record' do 
        expect(JSON.parse(response.body)['username']).to eq(username)

        should { change(User, :count).by(1) } 
      end
    end

    context 'with an invalid request' do 
      context "because of missing parameters" do 
        let(:invalid_params) do
          { 
            username: username,
            first_name: nil,
            last_name: last_name
          }
        end

        before { post '/users', params: invalid_params } 

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns an error message' do 
          expect(response.body).to match(/First name can't be blank/)
        end
      end
    end
  end
end