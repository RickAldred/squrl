require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  test "url attributes must not be empty" do
    url = Url.new
    assert url.invalid?
    assert url.errors[:original_url].any?
    assert url.errors[:squeezed_url].any?
  end

  test "url must have unique original url" do
    url = Url.new(original_url: urls(:google).original_url)
    assert url.invalid?
    assert_equal ["has already been taken"], url.errors[:original_url]
  end

  test "url must have unique squeezed url" do
    url = Url.new(squeezed_url: urls(:google).squeezed_url)
    assert url.invalid?
    assert_equal ["has already been taken"], url.errors[:squeezed_url]
  end

  test "original url format validation" do
    ok = %w{ http://www.abc.com http://www.abc.com/d https://www.abc.com}
    bad = %w{ www.abc.com wibble ftp://www.abc.com}
    
    ok.each do |name|
      assert Url.new(original_url: name, squeezed_url: "http://www.rick.com").valid?, "#{name} shouldn't be invalid"
    end
    
    bad.each do |name|
      assert Url.new(original_url: name, squeezed_url: "http://www.rick.com").invalid?, "#{name} shouldn't be valid"
    end
  end

  test "squeeze url" do
    original_url = "http://www.blah.com/blah1/blah2/blah3/blah4"

    url = Url.new
    url.squeeze_url original_url
    assert_equal original_url, url.original_url
    assert /[a-z0-9]+/ =~ url.squeezed_url
  end
end
