class Ability
  include CanCan::Ability

  def initialize user
   user ||= User.new
    if user.admin?
      can :manage, :all
      can :destroy, Review
    elsif user.user?
      can :read, :all
      can :update, User, user_id: user.id
      can :manage, Suggest
      can [:show, :find, :search, :searchlike], Book
      can [:create, :destroy], Review, user_id: user.id
      can [:create, :destroy], Comment, user_id: user.id
      can [:create, :destroy], Like
    else
      can :read, Book
      can :read, Category
    end
  end
end
