require 'spec_helper'

describe Tag do
  it "converts spaces in tags to dashes '-'"
  describe "validations" do
    let(:model) { Factory.build :tag }

    it "should have a short name" do
      model.name = 'this-tag-is-by-far-too-long'
      model.should be_invalid
    end

    it "shouln't have a name that's too short though" do
      model.name = 't'
      model.should be_invalid
    end

    it "should have a name" do
      model.name = ''
      model.should be_invalid
    end

    it "should prevent duplicates" do
      model.save!
      dup = Factory.build :tag, :name => model.name
      dup.should be_invalid
    end

    it "shouldn't have an underscore" do
      model.name = 'bad_tag'
      model.should be_invalid
    end

    it "shouldn't have spaces" do
      model.name = 'bad tag'
      model.should be_invalid
    end

    it "allows caps, dashes and numbers" do
      model.name = 'Tag-4'
      model.should be_valid
    end
  end
end
