# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    
    has_many :authored_polls,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :Poll

    has_many :responses,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Response

    has_many :questions,
        through: :authored_polls,
        source: :questions

    # def completed_polls

    #     self.responses.joins(:question).joins(:poll)


    #     <<-SQL
    #         SELECT
    #             polls.title, users.username, COUNT(questions.id) AS questions_per_poll, COUNT(users.id) AS answered_by_user
    #         FROM
    #             polls
    #             JOIN questions ON
    #             questions.poll_id = polls.id
    #             JOIN answer_choices ON
    #             answer_choices.question_id = questions.id
    #             JOIN responses ON
    #             responses.answer_choice_id = responses.id
    #             JOIN users ON
    #             responses.user_id = users.id
    #         GROUP BY
    #             polls.id, users.id
    #     SQL

        
    # end
end
