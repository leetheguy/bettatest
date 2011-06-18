require 'spec_helper'

describe SurveyOption do
  describe "validations" do
    let(:model) { Factory.build :survey_option }

    it "should have a short name" do
      model.name = 'this is a really really totally stupid ridiculously long name for a model that no one will ever remember'
      model.should be_invalid
    end

    it "should have a name" do
      model.name = ''
      model.should be_invalid
    end
  end
end
