require 'test_helper'
class TesterStatSheetTest < ActiveSupport::TestCase
  setup do
   @tss = Factory.build :tester_stat_sheet
  end

  test "standard validations" do
    decimal_level = Factory.build :tester_stat_sheet, :level => 3.6
    assert decimal_level.invalid?, decimal_level.errors.to_s

    high_level = Factory.build :tester_stat_sheet, :level => 42
    assert high_level.invalid?, high_level.errors.to_s

    decimal_points = Factory.build :tester_stat_sheet, :points => 3.6
    assert decimal_points.invalid?, decimal_points.errors.to_s
  end
end
