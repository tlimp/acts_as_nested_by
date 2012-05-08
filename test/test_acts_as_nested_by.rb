require 'helper'

class TestActsAsNestedBy < Test::Unit::TestCase
  db_setup

  context "ActiveRecord::Base decendant class" do
    should "respond to :acts_as_nested_by" do
      assert Foo.respond_to? :acts_as_nested_by
    end

    should "raise ArgumentError when trying to set :acts_as_nested_by for an undefined association" do
      assert_raise ArgumentError do
        class Bar < ActiveRecord::Base
          acts_as_nested_by :foo
        end
      end
    end

    should "raise ArgumentError when trying to set :acts_as_nested_by for association :has_many" do
      assert_raise ArgumentError do
        class Foo < ActiveRecord::Base
          has_many :bars
          acts_as_nested_by :bars
        end
      end
    end

    should "raise ArgumentError when trying to set :acts_as_nested_by for association :has_one" do
      assert_raise ArgumentError do
        class Foo < ActiveRecord::Base
          has_one :bar
          acts_as_nested_by :bar
        end
      end
    end
  end

  context "Instance of Bar (which acts_as_nested_by)" do
    setup do
      class Bar < ActiveRecord::Base
        belongs_to :foo
        acts_as_nested_by :foo
      end
      @bar = Bar.new
    end
    should "respond to :nested_by_foo=" do
      assert @bar.respond_to? :nested_by_foo=
    end

    should "respond to :nested_by_foo" do
      assert @bar.respond_to? :nested_by_foo
    end

    should "respond to :nested_by_foo?" do
      assert @bar.respond_to? :nested_by_foo?
    end

    should "return false when called #nested_by_foo if nested_by_foo was not set" do
      assert !@bar.nested_by_foo
    end

    should "return false when called #nested_by_foo if nested_by_foo was not set and called more than once" do
      assert !@bar.nested_by_foo
      assert !@bar.nested_by_foo
    end

    should "return false when called #nested_by_foo? if nested_by_foo was not set" do
      assert !@bar.nested_by_foo?
    end

    should "return true when called #nested_by_foo if nested_by_foo was set" do
      @bar = Bar.new(:nested_by_foo => 1)
      assert @bar.nested_by_foo
    end

    should "return true when called #nested_by_foo? if nested_by_foo was set" do
      @bar = Bar.new(:nested_by_foo => 1)
      assert @bar.nested_by_foo?
    end
  end

  db_teardown
end
