 require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users' do

    post('create user') do
			tags 'User Registration'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          age: { type: :string },
          password: { type: :string }
        },
        required: %w[username age password]
      }

      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/login' do

    post('login user') do
			tags 'Login'
      consumes 'application/json'
      parameter name: :login, in: :body, schema: {
        type: :object,
        properties: {
          username: { type: :string },
          password: { type: :string }
        },
        required: %w[username password]
      }
      response(200, 'successful') do
        let(:login) { { username: 'testuser', password: '2435647' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:login) { { username: 'testuser', password: '2435' } }
        run_test!
      end
    end
  end

  path '/auto_login' do

    get('auto_login user') do
			tags 'Auto Login'
      security [bearer_auth: []]
      response(200, 'successful') do
        response '201', 'authentication successful' do
          let(:Authorization) { "Bearer #{::Base64.strict_encode64('testuser:2435647')}" }
          run_test!
        end

        response '401', 'authentication failed' do
          let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
          run_test!
        end
      end
    end
  end
end
