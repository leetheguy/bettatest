require 'spec_helper'

describe UsersController do
  it "shows subscription info to user and admin"

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  describe "GET confirm_email" do
    it "makes an approved user a confirmed user" do
      unconfirmed
      get :confirm, :id => unconfirmed.id, :email_code => unconfirmed.email_code
      user = User.find unconfirmed.id
      response.should redirect_to user_path(user)
      user.should have_role :user
      user.should_not have_role :unconfirmed
    end
  end

  describe "GET index" do
    specify { can_has_access?(developer) { get :index } }

    it "creates lists of users separated by primary roles for admins" do
      login admin
      users = []
      18.times{ users << Factory.create(:user) }
      users[ 3..17].each { |user| user.has_no_roles!        }
      users[ 3..5 ].each { |user| user.has_role! :naughty   }
      users[ 6..8 ].each { |user| user.has_role! :user      }
      users[ 9..11].each { |user| user.has_role! :tester    }
      users[12..14].each { |user| user.has_role! :developer }
      users[15..17].each { |user| user.has_role! :admin     }
      get :index
      users[ 0..2 ].each { |user| assigns(:unconfirmed_users).should include user }
      users[ 3..5 ].each { |user| assigns(:naughty_users).should     include user }
      users[ 6..8 ].each { |user| assigns(:users).should             include user }
      users[ 9..11].each { |user| assigns(:testers).should            include user }
      users[12..14].each { |user| assigns(:developers).should         include user }
      users[15..17].each { |user| assigns(:admins).should             include user }
    end

    it "creates a list of users in a developer's tests for developers" do
      login developer
      u1 = Factory.create :user
      u2 = Factory.create :user
      u3 = Factory.create :user
      ua1 = [u1, u2]
      ua2 = [u1, u3]
      ua3 = [u2, u3]
      bt1 = Factory.create :beta_test, :user => developer
      bt2 = Factory.create :beta_test, :user => developer
      bt3 = Factory.create :beta_test, :user => developer
      tss = Factory.create :tester_stat_sheet, :user => u1, :beta_test => bt1
      tss = Factory.create :tester_stat_sheet, :user => u2, :beta_test => bt1
      tss = Factory.create :tester_stat_sheet, :user => u1, :beta_test => bt2
      tss = Factory.create :tester_stat_sheet, :user => u3, :beta_test => bt2
      tss = Factory.create :tester_stat_sheet, :user => u2, :beta_test => bt3
      tss = Factory.create :tester_stat_sheet, :user => u3, :beta_test => bt3
      developer
      get :index
      abt = assigns(:my_beta_tests)
      abt.should include bt1
      abt[abt.index(bt1)].users.should include u1
      abt[abt.index(bt1)].users.should include u2
      abt.should include bt2
      abt[abt.index(bt2)].users.should include u1
      abt[abt.index(bt2)].users.should include u3
      abt.should include bt3
      abt[abt.index(bt3)].users.should include u2
      abt[abt.index(bt3)].users.should include u3
    end
  end

  describe "GET show" do
    describe "allows everyone to view user profiles" do
      specify { can_has_access?(unconfirmed) { get :show } }
      specify { can_has_access?(naughty) { get :show } }
      specify { can_has_access?(user) { get :show } }
      specify { can_has_access?(tester) { get :show } }
      specify { can_has_access?(developer) { get :show } }
    end

    it "assigns user to current user if there is a session available" do
      login user
      get :show
      assigns(:user).should be_a_kind_of(User)
      response.should be_success
    end

    it "assigns user to id if it's available and no current user is available" do
      get :show, :id => user.id
      assigns(:user).should be_a_kind_of(User)
      response.should be_success
    end

    it "redirects to root if neither is available" do
      get :show
      response.should be_redirect
    end
  end

  describe "GET new" do
    specify { can_has_access? { get :new } }

    it "assigns a new user as @user" do
      User.stub(:new) { mock_user }
      get :new
      assigns(:user).should be(mock_user )
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created user as @user" do
        User.stub(:new).with({'these' => 'params'}) { mock_user(:save => true) }
        post :create, :user => {'these' => 'params'}
        assigns(:user).should be(mock_user)
      end

      it "redirects to the unconfirmed user page" do
        User.stub(:new) { mock_user(:save => true) }
        post :create, :user => {}
        response.should redirect_to(unconfirmed_user_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.stub(:new).with({'these' => 'params'}) { mock_user(:save => false) }
        post :create, :user => {'these' => 'params'}
        assigns(:user).should be(mock_user)
      end

      it "re-renders the 'new' template" do
        User.stub(:new) { mock_user(:save => false) }
        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "GET edit" do
    describe "admins can always edit users and users can edit their own account if they're not naughty or unconfirmed" do
      specify { can_has_access?   (user       ) { get :edit, :id => user.id        } }
      specify { cannot_has_access?(naughty    ) { get :edit, :id => naughty.id     } }
      specify { cannot_has_access?(unconfirmed) { get :edit, :id => unconfirmed.id } }
    end

    it "assigns the requested user as @user" do
      login admin
      user
      get :edit, :id => user.id
      assigns(:user).id.should be(user.id)
    end
  end

  describe "PUT update" do
    before do
      login user
    end
    
    it "needs to fix user update"

    it "renders edit if password doesn't match original" do
      new_user = { :betta_email_opt_in => true.to_param,
                   :password => "fooplarph",
                   :new_password => "".to_param,
                   :password_confirmation => "".to_param }
      put :update, :id => user.id, :user => new_user
      response.should render_template :edit
    end

    it "moves new password to password if new password is not empty" do

      put :update, :id => user.id,
                   :betta_email_opt_in => true.to_param,
                   :password => user.password.to_param,
                   :new_password => "newpass".to_param,
                   :password_confirmation => "newpass".to_param
      @controller.params[:password].should == "newpass"
      @controller.params[:password_confirmation].should == "newpass"
      response.should redirect_to dashboard_path
    end

    it "retains the contents of password and deletes new password if password is empty" do
      put :update, :id => user.id,
                   :betta_email_opt_in => true.to_param,
                   :password => user.password.to_param,
                   :new_password => "".to_param,
                   :password_confirmation => "".to_param
      @controller.params[:password].should == user.password
      @controller.params[:password_confirmation].should == user.password
      response.should redirect_to dashboard_path
    end

    it "redirects to dashboard after a successful update" do
      put :update, :id => user.id,
                   :betta_email_opt_in => true.to_param,
                   :password => user.password.to_param,
                   :new_password => "".to_param,
                   :password_confirmation => "".to_param
      response.should redirect_to dashboard_path
    end

    it "renders :edit after an unsuccessful update" do
      new_user = { :betta_email_opt_in => true.to_param,
               :password => user.password.to_param,
               :new_password => "newpass".to_param,
               :password_confirmation => "foobskablarph".to_param }
      put :update, :id => user.id, :user => new_user
      response.should render_template :edit
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      login admin
      delete :destroy, :id => user.id
      lambda {User.find(user.id)}.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
