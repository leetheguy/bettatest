require 'spec_helper'

describe ForumPost do
  describe "validations" do
    let(:model) { Factory.build :forum_post }

    it "should have a post" do
      model.post = ''
      model.should be_invalid
    end

    it "adds to score when rated up" do
      model.rate_up!
      ForumPost.find(model.id).score.should == 1
    end

    it "adds to score when rated down" do
      model.rate_down!
      ForumPost.find(model.id).score.should == -1
    end
  end

  it "assigns :owner role to user"
end
