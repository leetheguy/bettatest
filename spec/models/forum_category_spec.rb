require 'spec_helper'

describe ForumCategory do
  describe "validations" do
    let(:model) { Factory.build :forum_category }

    it "should have a short name" do
      model.name = 'this is a really really totally stupid ridiculously long name for a model that no one will ever remember'
      model.should be_invalid
    end

    it "should have a short description" do
      model.description = 'This is a super duper extra stupid ridiculously long description that was designed with the exclusive and sole porpoise... (Is that how you spell purpose?) of quite simply and dramatically dwarfing the model\'s name. And doing it once and for all. Never to be questioned. All your base are belong to us.'
      model.should be_invalid
    end

    it "should have a name" do
      model.name = ''
      model.should be_invalid
    end

    it "doesn't allow decimals as access levels" do
      model.access_level = 3.6
      model.should be_invalid
    end

    it "doesn't allow very high access levels" do
      model.access_level = 42
      model.should be_invalid
    end

    it "doesn't allow very low access levels" do
      model.access_level = -21
      model.should be_invalid
    end
  end

  it "returns categories appropriate for the user"
end
