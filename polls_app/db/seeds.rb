# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

User.create!(username: 'Wilson')
User.create!(username: 'Andre')
User.create!(username: 'Nick')
User.create!(username: 'Alvin')
User.create!(username: 'Hassib')

Poll.create!(author_id: 16, title: 'Hot Dogs')
Poll.create!(author_id: 19, title: 'PC vs Console')
Poll.create!(author_id: 20, title: 'Dogs or Cats')
Poll.create!(author_id: 16, title: 'APPLE VS ANDROID')
Poll.create!(author_id: 17, title: 'Donald Trump')

Question.create!(poll_id: 1, body: 'Ketchup or Mustard?')
Question.create!(poll_id: 2, body: 'PC or Console, for gaming ofc')
Question.create!(poll_id: 3, body: 'Are dogs better pets than cats or are cats better pets than dogs?')
Question.create!(poll_id: 4, body: 'What brand do you prefer?')
Question.create!(poll_id: 5, body: 'Should tweeter have unlimited chars?')
Question.create!(poll_id: 5, body: 'Should we ban his access to twitter?')

AnswerChoice.create!(question_id: 1, body: 'Ketchup') 
AnswerChoice.create!(question_id: 1, body: 'Mustard') 
AnswerChoice.create!(question_id: 1, body: 'Relish') 
AnswerChoice.create!(question_id: 2, body: 'PC')
AnswerChoice.create!(question_id: 2, body: 'Console') 
AnswerChoice.create!(question_id: 2, body: "I don't have time to for games. Or polls") 
AnswerChoice.create!(question_id: 3, body: 'Dogs') 
AnswerChoice.create!(question_id: 3, body: 'Cats') 
AnswerChoice.create!(question_id: 4, body: 'Apple') 
AnswerChoice.create!(question_id: 4, body: 'Android') 
AnswerChoice.create!(question_id: 5, body: 'Yes') 
AnswerChoice.create!(question_id: 5, body: 'No') 
AnswerChoice.create!(question_id: 6, body: 'Don\'t care') 
AnswerChoice.create!(question_id: 6, body: 'No') 
AnswerChoice.create!(question_id: 6, body: 'Yes') 

Response.create!(answer_choice_id: 1, user_id: 1)
Response.create!(answer_choice_id: 1, user_id: 4)
Response.create!(answer_choice_id: 1, user_id: 2)
Response.create!(answer_choice_id: 4, user_id: 1)
Response.create!(answer_choice_id: 8, user_id: 1)
Response.create!(answer_choice_id: 11, user_id: 1)
Response.create!(answer_choice_id: 15, user_id: 5)
Response.create!(answer_choice_id: 13, user_id: 1)
Response.create!(answer_choice_id: 14, user_id: 1)
Response.create!(answer_choice_id: 12, user_id: 4)
Response.create!(answer_choice_id: 6, user_id: 5)
Response.create!(answer_choice_id: 7, user_id: 1)
Response.create!(answer_choice_id: 5, user_id: 1)
Response.create!(answer_choice_id: 8, user_id: 4)
Response.create!(answer_choice_id: 9, user_id: 3)
Response.create!(answer_choice_id: 10, user_id: 2)
Response.create!(answer_choice_id: 15, user_id: 1)
Response.create!(answer_choice_id: 14, user_id: 4)
Response.create!(answer_choice_id: 13, user_id: 2)
Response.create!(answer_choice_id: 15, user_id: 4)



