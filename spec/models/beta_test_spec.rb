require 'spec_helper'

describe BetaTest do
  describe "validations" do
    let(:model) { Factory.build :beta_test }

    it "should have a short name" do
      model.name = 'this is a really really totally stupid ridiculously long name for a model that no one will ever remember'
      model.should be_invalid
    end

    it "should have a short description" do
      model.description = 3000.random_characters
      model.should be_invalid
    end

    it "should have a name" do
      model.name = ''
      model.should be_invalid
    end

    it "should prevent duplicates" do
      model.save!
      dup = Factory.build :beta_test, :name => model.name
      dup.should be_invalid
    end
  end

  it "assigns to user of new test developer status for test and universally" do
    bt = Factory.create :beta_test
    bt.user.has_role?(:developer).should be_true
    bt.user.has_role?(:developer, bt).should be_true
  end

  it "opens tests with open_test" do
    bt = Factory.create :beta_test, :open => false
    bt.open_test
    bt.open.should be_true
  end

  it "closes tests with close_test" do
    bt = Factory.create :beta_test, :open => true
    bt.close_test
    bt.open.should be_false
  end

  it "activates tests with activate_test" do
    bt = Factory.create :beta_test, :active => false
    bt.activate_test
    bt.active.should be_true
  end

  it "deactivates tests with deactivate_test" do
    bt = Factory.create :beta_test, :active => true
    bt.deactivate_test
    bt.active.should be_false
  end
end
