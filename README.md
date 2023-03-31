# README

## Running the application

- Firstly, cd into the application folder

- To run the dockerised app, first run `docker-compose up`

- Then run `docker exec translator_api-app-1 rails db:setup` to populate the database

## Running the tests

- Run `docker-compose run -e "RAILS_ENV=test" app rails db:seed` to populate the test database
- Run `docker-compose run -e "RAILS_ENV=test" app rspec` to run the tests
