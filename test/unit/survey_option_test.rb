require 'test_helper'

class SurveyOptionTest < ActiveSupport::TestCase
  setup do
   @so = Factory.build :survey_option
  end

  test "standard validations" do
    long_name = Factory.build :survey_option, :name => 'this is a really really totally stupid ridiculously long name for a forum category that no one will ever remember'
    assert long_name.invalid?, long_name.errors.to_s

    no_name = Factory.build :survey_option, :name => ''
    assert no_name.invalid?, no_name.errors.to_s
  end
end
