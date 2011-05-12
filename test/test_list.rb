require 'helper'

class TestList < Test::Unit::TestCase

  context "CitrusMail::List" do
    setup do
      @api_key = 'fake_key'
      @list_key = 'fake_list_key'
    end

    should "should be properly initialized and initialize client instance" do
      list = CitrusMail::List.new(@api_key, @list_key)
      assert list.client.is_a?(CitrusMail::Client)
    end
  end

  context "CitrusMail::List" do
    setup do
      @api_key = 'fake_key'
      @client = CitrusMail::Client.new(@api_key)
      @list_key = 'fake_list_key'
      @list = @client.get_list(@list_key)
    end

    should "" do
      assert true
    end
  end

end
