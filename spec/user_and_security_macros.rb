module UserAndSecurityMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
    
  module ClassMethods
  end

  def login(luser)
    session[:id] = luser.id
  end

  def unconfirmed
    if !@unconfirmed
      @unconfirmed = Factory.create :unconfirmed_user
      @unconfirmed.has_no_roles!
      @unconfirmed.has_role! :unconfirmed
    end
    @unconfirmed
  end

  def naughty
    if !@naughty
      @naughty = Factory.create :naughty_user
      @naughty.has_no_roles!
      @naughty.has_role! :naughty
    end
    @naughty
  end

  def user
    if !@user
      @user = Factory.create :user
      @user.has_no_roles!
      @user.has_role! :user
    end
    @user
  end

  def tester
    if !@tester
      @tester = Factory.create :tester
      @tester.has_no_roles!
      @tester.has_role! :tester
    end
    @tester
  end

  def developer
    if !@developer 
      @developer = Factory.create :developer
      @developer.has_no_roles!
      @developer.has_role! :developer
    end
    @developer
  end

  def subscriber
    if !@subscriber
      @subscriber = Factory.create :developer
      @subscriber.has_no_roles!
      @subscriber.has_role! :developer
      @subscriber.has_role! :subscriber
    end
    @subscriber
  end

  def admin
    if !@admin
      @admin = Factory.create :admin
      @admin.has_no_roles!
      @admin.has_role! :admin
    end
    @admin
  end

  def can_has_access?(luser = nil)
    login luser if luser
    lambda{ yield }.should_not raise_error(Acl9::AccessDenied)
  end

  def cannot_has_access?(luser = nil)
    login luser if luser
    lambda{ yield }.should_not raise_error(Acl9::AccessDenied)
    #yield.should be_redirect
  end
end
