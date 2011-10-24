class Ability
  include CanCan::Ability

  def initialize(user, test)
    #official_test = BetaTest.where(:name => "bettatest.com - developer's test")
    if user && test
      stats = test.stat_sheet_for(user)
    else
      stats = nil
    end
    user ||= User.new # guest user (not logged in)

    visitor = true
    nobody = true
    if user.roles != [] then visitor = false end
    if !visitor && !user.has_role?(:unconfirmed) && !user.has_role?(:naughty) then nobody = false end

#:visitor, :unconfirmed, :naughty
#:user, :tester, :developer, :subscriber, :admin
 
    can :read, BetaTest, :active => true
    if !nobody
      can :create, BetaTest, :active => false, :user_id => user.id
    end
    if test && user == test.user
      can [:read, :update, :destroy], BetaTest, :user_id => user.id
    end
    if user.has_role?(:admin)
      can :manage, BetaTest
    end

    if test
      if test.active
        can :read, Blog, :draft => false, :beta_test_id => test.id
      end
      if user.has_role?(:developer, test) || user.has_role?(:admin)
        can :manage, Blog, :beta_test_id => test.id
      end
    end

    if test
      if test.open
        can :read, ForumCategory, :beta_test_id => test.id
      end
      if stats && user.has_role?(:tester, test) && user.has_role?(:activated, test)
        can :read, ForumCategory, :beta_test_id => test.id, :access_level => 1..stats.level
      end
      if can? :update, BetaTest, :id => test.id
        can :manage, ForumCategory, :beta_test_id => test.id
      end
    end

    if test
      if test.open
        can :read, ForumTopic, :forum_category => { :beta_test_id => test.id }
      end
      if stats && user.has_role?(:tester, test) && user.has_role?(:activated, test)
        can :read, ForumTopic, :forum_category => { :beta_test_id => test.id, :access_level => 1..stats.level }
        can :create, ForumTopic
      end
      if can? :update, BetaTest, :id => test.id
        can :manage, ForumTopic, :forum_category => { :beta_test_id => test.id }
      end
    end

    if test
      if test.open
        can :read, ForumPost, :forum_topic => { :forum_category => { :beta_test_id => test.id } }
      end
      if stats && user.has_role?(:tester, test) && user.has_role?(:activated, test)
        can :read, ForumPost, :forum_topic => { :forum_category => { :beta_test_id => test.id, :access_level => 1..stats.level } }
        can :create, ForumPost
        can :update, ForumPost, :user_id => user.id
        if !test.open
          can :rate_up, ForumPost
          can :rate_down, ForumPost
        end
      end
      if can? :update, BetaTest, :id => test.id
        can :manage, ForumPost, :forum_topic => { :forum_category => { :beta_test_id => test.id } }
        cannot :rate_up, ForumPost
        cannot :rate_down, ForumPost
      end
    end

    if !nobody && !user.has_role?(:subscriber)
      can :create, Subscription, :user_id => user.id
    end
    if user.has_role?(:subscriber)
      can [:read, :update, :destroy], Subscription, :user_id => user.id
    end
    if user.has_role?(:admin)
      can :manage, Subscription
    end

    if test
      if !nobody && !user.has_role?(:tester, test) && !user.has_role?(:developer, test) && !user.has_role?(:admin) && !test.open
        can :create, TesterStatSheet, :user_id => user.id, :beta_test_id => test.id
      end
      if ((user.has_role?(:tester, test) && user.has_role?(:activated, test)) || user.has_role?(:developer, test) || user.has_role?(:admin)) && !test.open
        can :read, TesterStatSheet, :beta_test_id => test.id
      end
    end

    can :read, User
    if nobody || user.has_role?(:admin)
      can :confirm
    end
    if visitor
      can :create, User
    end
    if !visitor && !user.has_role?(:naughty)
      can :update, User, :id => user.id
    end
    if user.has_role?(:admin)
      can :manage, User
    end

# a visitor has no roles
# unconfirmed and naughty users have the same permissions as visitors
# a user who has not created or joined a bt has the role user
# a user who is a tester
#   has the user role removed
#   has the tester role added
# a user who is a developer
#   has the user role removed
#   has the developer role added
#   can also be a tester
# a user who is a subscriber
#   has the user role removed
#   has the developer role removed
#   has the developer role added
#   can also be a tester
# a user who is an admin
#   is omnipotetent
#   is nominally competent
#   should not have any other roles
#   should not have any restrictions

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
