# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        { url: 'https://alumni-portfolio-api.herokuapp.com' },
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          bearer_auth: {
            type: :http,
            scheme: :bearer
          }
        },
        schemas: {
          sunny_episode: {
            type: :object,
            properties: {
              id: { type: :integer },
              title: { type: :string },
              description: { type: :string },
              number: { type: :integer },
              season: { type: :integer },
              episode: { type: :integer },
              airdate: { type: :string },
              tvmaze_link: { type: :string },
              created_at: { type: :string },
              updated_at: { type: :string }
            }
          },
          github_repo: {
            type: :object,
            properties: {
              id: { type: :integer },
              names: { type: :string },
              full_name: { type: :string },
              category: { type: :string },
              forks_count: { type: :integer },
              watchers_count: { type: :integer },
              popularity_rating: { type: :integer }
            }
          },
          new_session: {
            type: :object,
            properties: {
              user: {
                type: :object,
                schema: { '$ref' => '#/components/schemas/user' }
              },
              token: { type: :string }
            }
          },
          unauthorized: {
            type: :object,
            properties: {
              errors: {
                type: :object,
                properties: {
                  error: { type: :string }
                }
              }
            }
          },
          user: {
            type: :object,
            properties: {
              username: { type: :string },
              avatar_url: { type: :string }
            }
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
