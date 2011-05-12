require 'helper'

class TestClient < Test::Unit::TestCase

  context "CitrusMail::Client" do
    setup do
      @api_key = 'fake_key'
      @client = CitrusMail::Client.new(@api_key)
    end

    context "#flatten_params with {'a' => 'b', 'c' => {'d' => 'e', 'f' => 'g'}}" do
      should "return {'a' => 'b', 'c[d]' => 'e', 'c[f]' => 'g'}" do
        params = {'a' => 'b', 'c' => {'d' => 'e', 'f' => 'g'}}
        ret = @client.flatten_params(params)
        assert ret == {'a' => 'b', 'c[d]' => 'e', 'c[f]' => 'g'}
      end
    end

    context "#process_params with {'a' => 'b'}" do
      should "return {'a' => 'b', :api_key => 'fake_key'}" do
        params = {'a' => 'b'}
        ret = @client.process_params(params)
        assert ret == {'a' => 'b', :api_key => @api_key}
      end
    end

    context "#get_list with list_key" do
      setup do
        @list_key = "fake_list_key"
      end

      should "return CitrusMail::List instance" do
        list = @client.get_list(@list_key)
        assert list.is_a?(CitrusMail::List)
      end
    end

  end

end
