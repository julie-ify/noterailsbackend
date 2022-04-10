require 'swagger_helper'

RSpec.describe 'notes', type: :request do

  path '/notes' do

    get('list notes') do
			tags 'Notes'
      security [bearer_auth: []]
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

			response '201', 'successfully authenticated' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('testuser:2435647')}" }
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end
    end

    post('create note') do
			tags 'Notes'
			security [bearer_auth: []]
			consumes 'application/json'        
			parameter name: :note, in: :body, schema: {          
			type: :object,          
			properties: {            
				title: { type: :string },            
				body: { type: :string }          
			},          
			required: %w[title body]  
			}

			response '201', 'note created' do
        let(:note) do
          { title: 'Note1', body: 'This is note 1' }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:note) { { title: 'Note1'} }
        run_test!
      end

      response '201', 'successfully authenticated' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('testuser:2435647')}" }
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end

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

  path '/notes/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show note') do
			tags 'Notes'
      security [bearer_auth: []]
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

			response '201', 'successfully authenticated' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('testuser:2435647')}" }
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end
    end

    put('update note') do
			tags 'Notes'
      security [bearer_auth: []]
			consumes 'application/json'        
			parameter name: :note, in: :body, schema: {          
			type: :object,          
			properties: {            
				title: { type: :string },            
				body: { type: :string }          
			},          
			required: %w[title body]  
			}
			let(:id) { '123' }

			

			response '201', 'note updated' do
        let(:note) do
          { title: 'Note1', body: 'This is note 1.1' }
        end
        run_test!
      end

      response '422', 'invalid request' do
        let(:note) { { title: 'note1'} }
        run_test!
      end

      response '201', 'successfully authenticated' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('testuser:2435647')}" }
        run_test!
      end

      response '401', 'authentication failed' do
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }
        run_test!
      end

      response '200', 'successful' do
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

    delete('delete note') do
			tags 'Notes'
      security [bearer_auth: []]
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

			response '201', 'successfully authenticated' do
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
