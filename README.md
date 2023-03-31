# README

## Running the application with Docker

- Firstly, cd into the application folder

- To run the dockerised app, first run `docker-compose up`

- Then run `docker exec translator_api-app-1 rails db:setup` to populate the database

- The API is accessible in `http://localhost:3000/`

## Running the tests inside the Docker container

- Run `docker-compose run -e "RAILS_ENV=test" app rails db:seed` to populate the test database

- Run `docker-compose run -e "RAILS_ENV=test" app rspec` to run the tests

## Running the application without Docker

- The app requires `ruby '3.2.1'` installed

- Firstly, cd into the application folder

- Run `bundle install` (you will need `sudo gem install bundler` if not installed)

- Run `bin/rails db:setup` to migrate and seed the development database

- Run `bin/rails server` to start the server

- The API is accessible in `http://localhost:3000/`

## Running the tests locally

- Run `bin/rails db:setup RAILS_ENV=test` to migrate and seed the test database
- Run`bundle exec rspec `

---

## Requests

```
# Getting glossaries data:

curl --location --request GET 'http://127.0.0.1:3000/api/glossaries' \
--header 'Content-Type: application/json' | json_pp

# Will produce:

[
    {
        "id": 1,
        "target_language_code": "es",
        "source_language_code": "en",
        "terms": [
            {
                "id": 1,
                "source_term": "recruitment",
                "target_term": "reclutamiento"
            }
        ]
    }
]
```

```
# Fetching on specific glossary:

curl --location --request GET 'http://127.0.0.1:3000/api/glossaries/1' \
--header 'Content-Type: application/json' | json_pp

# Will produce:

{
    "id": 1,
    "target_language_code": "es",
    "source_language_code": "en",
    "terms": [
        {
            "id": 1,
            "source_term": "recruitment",
            "target_term": "reclutamiento"
        }
    ]
}
```

```
# Create new glossaries is possible:

curl --location 'http://127.0.0.1:3000/api/glossaries' \
--header 'Content-Type: application/json' \
--data '{
    "glossary": {
        "source_language_code": "it",
        "target_language_code": "es"
    }
}'

# Will return:

{
    "id": 2,
    "target_language_code": "es",
    "source_language_code": "it",
    "terms": []
}
```

```
# As well as adding new terms:
curl --location 'http://127.0.0.1:3000/api/glossaries/1/terms' \
--header 'Content-Type: application/json' \
--data '{
    "term": {
        "source_term": "hello",
        "target_term": "hola"
    }
}' | json_pp

# Will return:

{
    "id": 2,
    "source_term": "hello",
    "target_term": "hola"
}

```

```
# Translation can be created:

curl --location 'http://127.0.0.1:3000/api/translations' \
--header 'Content-Type: application/json' \
--data '{
    "translation": {
        "source_language_code": "it",
        "target_language_code": "es",
        "source_text": "translate this text"
    }
}' | json_pp

# Will return:

{
    "id": 2,
    "glossary_id": 2,
    "source_text": "translate this text"
}
```

```
# Translations can be cheked too:

curl --location --request GET 'http://127.0.0.1:3000/api/translations/1' \
--header 'Content-Type: application/json' \
--data '{
    "translation": {
        "source_language_code": "it",
        "target_language_code": "es",
        "source_text": "translate this"
    }
}' | json_pp

# Will return:

{
    "source_text": "This is a recruitment task.",
    "glossary_terms": [
        "recruitment"
    ],
    "highlighted_source_text": "This is a <HIGHLIGHT>recruitment</HIGHLIGHT> task."
}
```

---
