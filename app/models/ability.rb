class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new # guest user (not logged in)

    can :read, [Comment]

    if user&.user?
      can %i(update read), User, id: user.id
      can :manage, Comment
      can %i(read create update order_soccer_field), Order
    end

    can :manage, :all if user&.admin?
  end
end
