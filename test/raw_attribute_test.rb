require 'test_helper'

class User < ActiveRecord::Base
  raw_attribute :title
end

class RawAttributeTest < ActiveSupport::TestCase
  test "html will render as raw when attribute specified" do
    user = User.new(:title => "<script>title</script>", :address => "<script>address</script>")

    puts "-------------> #{user.title}"
    puts "-------------> #{user.address}"

    assert_equal user.title.html_safe?, false
    assert_equal user.address.html_safe?, true
  end

  test "return raw output" do
    raw = RawHtml::Base.raw("<script>name</script>")

    assert_equal raw.html_safe?, false
  end
end

