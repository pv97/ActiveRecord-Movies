# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response



  def completed_polls
    #User.first.responses.joins(:answer_choice).joins(:question).group("questions.poll_id").count("questions.id")
    #
    # connection = ActiveRecord::Base.connection
    # x = connection.execute(<<-SQL)
    #x = User.find(2).responses.joins(:question).joins("JOIN polls ON questions.poll_id = polls.id").group("polls.id").count("questions.id")
    #y = Poll.joins(:questions).group("polls.id").having("COUNT(questions.id) > ?",x)

    Poll.find_by_sql(
    "      SELECT polls.id
          FROM polls
          LEFT JOIN questions
            ON questions.poll_id = polls.id
          LEFT JOIN answer_choices ac
            on ac.question_id = questions.id
          LEFT JOIN responses
            on responses.answer_choice_id = ac.id
          LEFT JOIN users
            on users.id = responses.user_id
          WHERE users.id = #{self.id}
          GROUP BY
            polls.id
          HAVING
            COUNT(DISTINCT questions.id) = COUNT(responses.user_id)
    ")


    # SQL
  end
end
