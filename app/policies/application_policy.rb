# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def recordAuthor?
    @user.id == @record.user_id
  end

  def show?
    recordAuthor?|| @user.admin?|| @record.published?
  end

  def update?
    recordAuthor?
  end

  def destroy?
    recordAuthor?
  end
  
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
