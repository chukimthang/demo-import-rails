class AdminAbility
  include CanCan::Ability

  def initialize admin
    admin ||= Admin.new

    if admin.super_admin?
      can :manage, :all
    else
      can :manage, []
    end
  end
end
