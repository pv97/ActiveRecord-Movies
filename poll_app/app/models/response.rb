# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_already_answered?
  validate :respondent_is_author?

  def sibling_responses
    self.question.responses.where.not(:responses => {id: self.id})
  end

  def respondent_already_answered?
    if sibling_responses.exists?(user_id: self.user_id)
      self.errors[:you] << "can only respond once"
    end
  end

  def respondent_is_author?
    if self.question.poll.user_id == self.user_id
      self.errors[:you] << "can't answer your questions"
    end
  end

  # wouldn't this be a belong to since both are bleongs to?
  has_one :question,
    through: :answer_choice,
    source: :question

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice
end
