# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    return if user.blank?

    can :manage, Result, user_id: user.id
    can :manage, Exam, user_id: user.id
    can :manage, User, id: user.id
    can :manage, Record

    can :read, [Question, QuestionsExam, Subject, Exam, Answer, Topic]
    return unless user.admin_role? || user.trainer_role?

    can :manage, [Question, QuestionsExam, Subject, Topic, Exam, Answer, Record, Result]
    if user.admin_role?
      can :manage, :all
    end
  end
end
