# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(user_name: "Pi")
User.create!(user_name: "Alex")

Poll.create!(title: "test poll one", user_id: 1)
Poll.create!(title: "test poll two", user_id: 1)


Question.create!(poll_id: 1, question: "what?")
Question.create!(poll_id: 1, question: "huh?")
Question.create!(poll_id: 2, question: "2what?")
Question.create!(poll_id: 2, question: "2huh?")

AnswerChoice.create!(question_id: 1, answer: "answer1.1")
AnswerChoice.create!(question_id: 1, answer: "answer1.2")
AnswerChoice.create!(question_id: 2, answer: "answer2.1")
AnswerChoice.create!(question_id: 2, answer: "answer2.2")
AnswerChoice.create!(question_id: 3, answer: "answer3.1")
AnswerChoice.create!(question_id: 3, answer: "answer3.2")
AnswerChoice.create!(question_id: 4, answer: "answer4.1")
AnswerChoice.create!(question_id: 4, answer: "answer4.2")

Response.create!(user_id: 1, answer_choice_id: 1)
Response.create!(user_id: 2, answer_choice_id: 1)
Response.create!(user_id: 1, answer_choice_id: 3)
Response.create!(user_id: 2, answer_choice_id: 4)
