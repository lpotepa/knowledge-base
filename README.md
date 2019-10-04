# Requirements

- Redis (3.0.6+)
- PostgreSQL

# Tech stack

- Ruby on Rails 6 as a backend framework
- StimulusJS as a frontend framework (installed via webpacker)
- PostgreSQL
- Redis (for background jobs)

# Demo

https://knowledge-base-lpotepa.herokuapp.com/

# Setup example

 ```
  bundle install
  yarn install
  rake db:create; db:migrate
  rake language:add German de
  rails s
 ```
# Tests

 ```
  rspec
 ```
 
# Note
 This is a simple web application written in Ruby/Javascript. It allows the user to create an article with question an answer. Questions and answers are automatically translated into pre-defined multiple languages. It depends on Microsoft Translator. The backend comunicates via JSON API.
 
# API reference

```
  GET /api/v1/articles
  
  List all articles in descending order (by creation date)
```
```
  GET /api/v1/articles/:id
  
  Returns a single article with its question and answer and their translations.
```

```
  POST /api/v1/articles/
  
  Creates an article. Required parameters:
  
  question_attributes - an object having a "content" key, which represents the question's content
  answer_attributes - an object having a "content" key, which represents the question's content
  
  Example:
  
  curl 'http://localhost:3000/api/v1/articles' -XPOST --data-binary '{"question_attributes":{"content":"Very good            question"},"answer_attributes":{"content":"Very good advice"}}' --compressed
```
```
  PUT /api/v1/articles/:id
  
  Updates an article. Required parameters:
  
  id
  question_attributes - an object having a "content" key, which represents the question's content
  answer_attributes - an object having a "content" key, which represents the question's content
  
  Example:
  
  curl 'http://localhost:3000/api/v1/articles/8297d774-41ef-4b93-b809-53791c86307f' -XPUT --data-binary '{"question_attributes":{"content":"Very good question"},"answer_attributes":{"content":"Very good advice"}}' --compressed
```

```
  DELETE /api/v1/articles/:id
  
  Deletes an article. Required parameters:
  
  -id
```
 
