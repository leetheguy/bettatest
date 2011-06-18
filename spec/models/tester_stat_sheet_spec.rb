require 'spec_helper'

describe TesterStatSheet do
  def beta_test
    @beta_test ||= Factory.create :beta_test, :max_testers => 3
    @beta_test
  end

  describe "validations" do
    let(:user)      { Factory.create :tester }
    let(:beta_test) { Factory.create :beta_test }
    let(:model)     { Factory.create :tester_stat_sheet , :user => user, :beta_test => beta_test }

    it "should not have a decimal for a level" do
      model.level = 3.6
      model.should be_invalid
    end

    it "shouldn't be a high level number" do
      model.level = 42
      model.should be_invalid
    end

    it "should not have a decimal for points" do
      model.points = 3.6
      model.should be_invalid
    end
  end

  describe "logic" do
    def user1
      @user1 ||= Factory.create :tester
      @user1.has_no_roles!
      @user1.has_role! :user
      @user1
    end

    def user2
      @user2 ||= Factory.create :tester
      @user2.has_no_roles!
      @user2.has_role! :user
      @user2
    end

    def user3
      @user3 ||= Factory.create :tester
      @user3.has_no_roles!
      @user3.has_role! :user
      @user3
    end

    def user4
      @user4 ||= Factory.create :tester
      @user4.has_no_roles!
      @user4.has_role! :user
      @user4
    end

    def user5
      @user5 ||= Factory.create :tester
      @user5.has_no_roles!
      @user5.has_role! :user
      @user5
    end

    def tss1
      @tss1 ||= Factory.create :tester_stat_sheet, :beta_test => beta_test, :user => user1
      @tss1
    end

    def tss2
      @tss2 ||= Factory.create :tester_stat_sheet, :beta_test => beta_test, :user => user2
      @tss2
    end

    def tss3
      @tss3 ||= Factory.create :tester_stat_sheet, :beta_test => beta_test, :user => user3
      @tss3
    end

    def tss4
      @tss4 ||= Factory.create :tester_stat_sheet, :beta_test => beta_test, :user => user4
      @tss4
    end

    def tss5
      @tss5 ||= Factory.create :tester_stat_sheet, :beta_test => beta_test, :user => user5
      @tss5
    end

    it "assigns appropriate roles to a new tester" do
      tss1.user.should_not have_role :user
      tss1.user.should have_role :tester
      tss1.user.should have_role :tester, beta_test
    end

    it "assigns new users with the next position in line" do
      tss1.position.should == 1
      tss2.position.should == 2
      tss3.position.should == 3
      tss4.position.should == 4
      tss5.position.should == 5
    end

    it "assigns new users with points and a level" do
      tss1.points.should == 10
      tss1.should be_activated
      tss2.points.should == 10
      tss2.should be_activated
      tss3.points.should == 10
      tss3.should be_activated
      tss4.points.should == 10
      tss4.should be_waiting
      tss5.points.should == 10
      tss5.should be_waiting
    end

    it "adds points with add_points!" do
      pts = tss1.points
      tss1.add_points! 42
      tss1.points.should == pts + 42
    end

    it "removes points with remove_points!" do
      pts = tss1.points
      tss1.remove_points! 42
      tss1.points.should == pts - 42
    end

    it "activates activated users" do
      tss1
      tss2
      tss3
      tss4
      tss5
      tss1.remove_points! tss1.points
      tss = TesterStatSheet.find(@tss4.id)
      tss.should be_activated
      tss.user.should have_role :activated, tss.beta_test
    end
    
    it "promotes active users" do
      tss1.add_points! 20
      tss = TesterStatSheet.find(@tss1.id)
      tss.user.should have_role :active, tss.beta_test
    end

    it "promotes involved users" do
      tss1.add_points! 70
      tss = TesterStatSheet.find(@tss1.id)
      tss.user.should have_role :involved, tss.beta_test
    end

    it "promotes involved users" do
      tss1.add_points! 70
      tss1.remove_points! 70
      tss = TesterStatSheet.find(@tss1.id)
      tss.user.should_not have_role :involved, tss.beta_test
      tss.user.should_not have_role :active, tss.beta_test
    end

    describe "level and role adjustment" do
      describe "- tester removal" do
        before do
          tss1
          tss2
          tss3
          tss4
          tss5
          tss2.remove_points! tss2.points
        end

        it "sets tester level to -1" do
          tss2.level.should == -1
        end

        it "should be off the position list" do
          tss2.position.should == -1
        end

        it "deactivates user" do
          tss2.user.should have_role :deactivated, beta_test
        end

        it "moves other testers forward in the queueue" do
          TesterStatSheet.find(@tss1.id).position.should == 1
          TesterStatSheet.find(@tss3.id).position.should == 2
          TesterStatSheet.find(@tss4.id).position.should == 3
          TesterStatSheet.find(@tss5.id).position.should == 4
        end
      end

      describe "activated tester adjustment" do
        it "activates activated users" do
        end
      end
    end

    describe "named adjustments" do
      it "removes daily_drop_pts on a day passed" do
        points = tss1.points
        tss1.day_passed!
        tss1.points.should == points - beta_test.daily_drop_pts
      end

      it "adds login_pts on login" do
        points = tss1.points
        tss1.logged_in!
        tss1.points.should == points + beta_test.daily_login_pts
      end

      it "adds forum_post_pts on a post" do
        points = tss1.points
        tss1.forum_post!
        tss1.points.should == points + beta_test.forum_post_pts
      end

      it "removes rate_up_lose_pts on an up rating" do
        post = Factory.create :forum_post, :user => tss2.user
        points = tss1.points
        tss1.forum_rate_up!(post)
        tss1.points.should == points - beta_test.rate_up_lose_pts
      end

      it "gives rate_up_give_pts on an up rating" do
        post = Factory.create :forum_post, :user => tss2.user
        points = tss2.points
        tss1.forum_rate_up!(post)
        tss = TesterStatSheet.find(tss2.id)
        tss.points.should == points + beta_test.rate_up_give_pts
      end

      it "removes rate_down_lose_pts on a down rating" do
        post = Factory.create :forum_post, :user => tss2.user
        points = tss1.points
        tss1.forum_rate_down!(post)
        tss1.points.should == points - beta_test.rate_down_lose_pts
      end

      it "takes rate_down_take_pts on a down rating" do
        post = Factory.create :forum_post, :user => tss2.user
        points = tss2.points
        tss1.forum_rate_down!(post)
        tss = TesterStatSheet.find(tss2.id)
        tss.points.should == points - beta_test.rate_down_take_pts
      end

      it "adds survey_vote_pts on a survey vote" do
        points = tss1.points
        tss1.survey_vote
        tss1.points.should == points + beta_test.survey_vote_pts
      end
    end
  end
end
