# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.is_admin?
      can :manage, :all
    else
      can [:index, :browse, :search, :show, :new, :create], Listing
      can [:edit, :update, :destroy], Listing, user_id: user.id
    end
  end
end
