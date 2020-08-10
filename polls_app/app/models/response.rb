# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  answer_choice_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Response < ApplicationRecord
    validate :is_author?
    validate :respondent_already_answered?
    

    belongs_to :respondent,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    belongs_to :answer_choice,
        primary_key: :id,
        foreign_key: :answer_choice_id,
        class_name: :AnswerChoice

    has_one :question,
        through: :answer_choice,
        source: :question

    def sibling_responses
        self.question.responses.where.not(user_id: self.id)
    end

    def respondent_already_answered?
        if !sibling_responses.find_by(user_id: self.user_id).nil?
            errors[:duplicate] << "Duplicate respondent"
        end
    end

    def is_author?
        errors[:fraud] << "Respondent is the author" if self.user_id == self.question.author.id
    end
end
