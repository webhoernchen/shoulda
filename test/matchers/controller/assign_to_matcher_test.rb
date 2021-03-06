require 'test_helper'

class AssignToMatcherTest < ActionController::TestCase # :nodoc:

  context "a controller that assigns to an instance variable" do
    setup do
      @controller = build_response { @var = 'value' }
    end

    should "accept assigning to that variable" do
      assert_accepts assign_to(:var), @controller
    end

    should "accept assigning to that variable with the correct class" do
      assert_accepts assign_to(:var).with_kind_of(String), @controller
    end

    should "reject assigning to that variable with another class" do
      assert_rejects assign_to(:var).with_kind_of(Fixnum), @controller
    end

    should "accept assigning the correct value to that variable" do
      assert_accepts assign_to(:var).with('value'), @controller
    end

    should "reject assigning another value to that variable" do
      assert_rejects assign_to(:var).with('other'), @controller
    end

    should "reject assigning to another variable" do
      assert_rejects assign_to(:other), @controller
    end

    should "accept assigning to the same value in the test context" do
      @expected = 'value'
      assert_accepts assign_to(:var).with { @expected }, @controller
    end

    should "reject assigning to the another value in the test context" do
      @expected = 'other'
      assert_rejects assign_to(:var).with { @expected }, @controller
    end
  end

  context "a controller that assigns a nil value to an instance variable" do
    setup do
      @controller = build_response { @var = nil }
    end

    should "accept assigning to that variable" do
      assert_accepts assign_to(:var), @controller
    end
  end

end
