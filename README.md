# README

## Purpose

This API-only application implements a translation highlight between two diferent languages.

The API gives information about the existing dictionaries (called glossaries) as well as the option to create new ones.

Once a glossary is created, new terms can be added to it, so transaltions are possible between the given languages.

Once a glossary has terms mapping the two different languages, a translation for a given sentence can be created and later on retrieved.

Translations will highlight the terms selected to be translated.

Example:
Given an user provides the English sentence `"This is a cup for you"`, where `"cup"` is the word to be translated to Spanish, the user will receive back `"This is a <HIGHLIGHT>cup</HIGHLIGHT> for you"`

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

curl --location --request GET 'http://127.0.0.1:3000/api/v1/glossaries' \
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
                "target_term": "taza",
                "source_term": "cup"
            }
        ]
    }
]
```

```
# Fetching on specific glossary:

curl --location --request GET 'http://127.0.0.1:3000/api/v1/glossaries/1' \
--header 'Content-Type: application/json' | json_pp

# Will produce:

{
    "id": 1,
    "target_language_code": "es",
    "source_language_code": "en",
    "terms": [
        {
            "id": 1,
            "target_term": "cup",
            "source_term": "taza",
        }
    ]
}
```

```
# Create new glossaries is possible:

curl --location 'http://127.0.0.1:3000/api/v1/glossaries' \
--header 'Content-Type: application/json' \
--data '{
    "glossary": {
        "target_language_code": "en",
        "source_language_code": "it"
    }
}'

# Will return:

{
    "id": 2,
    "source_language_code": "it",
    "target_language_code": "en",
    "terms": []
}
```

```
# As well as adding new terms:
curl --location 'http://127.0.0.1:3000/api/v1/glossaries/1/terms' \
--header 'Content-Type: application/json' \
--data '{
    "terms": [{
        "source_term": "this",
        "target_term": "esto"
    }]
}' | json_pp

# Will return:

{
    "id": 2,
    "source_term" : "this",
    "target_term" : "esto"
}

```

```
# Translation can be created:

curl --location 'http://127.0.0.1:3000/api/v1/translations' \
--header 'Content-Type: application/json' \
--data '{
    "translation": {
        "source_language_code": "en",
        "target_language_code": "es",
        "source_text": "This is a cup of coffee"
    }
}' | json_pp

# Will return:

{
    "id": 2,
    "glossary_id": 2,
    "source_text": "This is a cup of coffee"
}
```

```
# Translations can be cheked too:

curl --location --request GET 'http://127.0.0.1:3000/api/v1/translations/1' \
--header 'Content-Type: application/json' \
--data '{
    "translation": {
        "source_language_code": "en",
        "target_language_code": "es",
        "source_text": "This is a cup of coffee"
    }
}' | json_pp

# Will return:

{
    "source_text": "This is a cup of coffee",
    "glossary_terms": [
        "cup"
    ],
    "highlighted_source_text": "This is a white <HIGHLIGHT>cup</HIGHLIGHT>."
}
```

---
