class PostPolicy < ApplicationPolicy
  def destroy?
    @user.admin?
  end
  
  class Scope < Scope
    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(published: true).or(scope.where(user_id: @user.id))
      end
    end
  end
end
