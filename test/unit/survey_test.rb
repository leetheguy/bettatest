require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  setup do
   @survey = Factory.build :survey
  end

  test "standard validations" do
    long_name = Factory.build :survey, :name => 'this is a really really totally stupid ridiculously long name for a forum category that no one will ever remember'
    assert long_name.invalid?, long_name.errors.to_s

    long_description = Factory.build :survey, :description => 'This is a super duper extra stupid ridiculously long description that was designed with the exclusive and sole porpoise... (Is that how you spell purpose?) of quite simply and dramatically dwarfing the forum category\'s name. And doing it once and for all. Never to be questioned. All your base are belong to us.'
    assert long_description.invalid?, long_description.errors.to_s

    no_name = Factory.build :survey, :name => ''
    assert no_name.invalid?, no_name.errors.to_s

    decimal_access_level = Factory.build :survey, :access_level => 3.6
    assert decimal_access_level.invalid?, decimal_access_level.errors.to_s

    high_access_level = Factory.build :survey, :access_level => 42
    assert high_access_level.invalid?, high_access_level.errors.to_s

    low_access_level = Factory.build :survey, :access_level => -21
    assert low_access_level.invalid?, low_access_level.errors.to_s
  end
end
