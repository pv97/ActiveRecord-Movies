# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  question   :text             not null
#  poll_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :question, :poll_id, presence: true


  has_many :responses,
    through: :answer_choices,
    source: :responses

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice

  def results
    self.responses.group(:answer).count(:answer)

    #answers =  self.answer_choices.includes(:responses)
    # answer_hash = Hash.new(0)

    #answers.each do |answer|
      #answer_hash[answer.answer] = answer.responses.count
    #end

    #answer_hash

  end

end
