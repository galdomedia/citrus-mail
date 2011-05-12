require 'helper'

class FakeHttpResponse < Struct.new(:code, :body)
end

class TestResponse < Test::Unit::TestCase

  context "CitrusMail::Response" do
    setup do
    end

    context "when http code is not 200" do
      setup do
        @http_response = FakeHttpResponse.new('100', '<root><response>1</response></root>')
      end
      should "raise CitrusMail::RequestFailed" do
        exception = nil
        begin
          CitrusMail::Response.build_from_http_response(@http_response)
        rescue => e
          exception = e
        end
        assert exception.is_a?(CitrusMail::RequestFailed)
      end
    end

    context "when http code is 200 and response body has no <response> xml tag" do
      setup do
        @http_response = FakeHttpResponse.new('200', 'something')
      end
      should "raise CitrusMail::RequestFailed" do
        exception = nil
        begin
          CitrusMail::Response.build_from_http_response(@http_response)
        rescue => e
          exception = e
        end
        assert exception.is_a?(CitrusMail::RequestFailed)
      end
    end

    context "when freshmail response is greater than 100" do
      setup do
        @http_response = FakeHttpResponse.new('200', '<root><response>201</response></root>')
      end
      should "raise CitrusMail::CitrusMailError" do
        exception = nil
        begin
          CitrusMail::Response.build_from_http_response(@http_response)
        rescue => e
          exception = e
        end
        assert exception.is_a?(CitrusMail::CitrusMailError)
      end
    end

    context "when freshmail response is greater than 100" do
      setup do
        @http_response = FakeHttpResponse.new('200', '<root><response>201</response></root>')
      end
      should "raise CitrusMail::CitrusMailError" do
        exception = nil
        begin
          CitrusMail::Response.build_from_http_response(@http_response)
        rescue => e
          exception = e
        end
        assert exception.is_a?(CitrusMail::CitrusMailError)
      end
    end

    context "when freshmail response is lower than 100" do
      setup do
        @http_response = FakeHttpResponse.new('200', '<root><response>1</response></root>')
      end
      should "return CitrusMail::Response" do
        ret = CitrusMail::Response.build_from_http_response(@http_response)
        assert ret.is_a?(CitrusMail::Response)
      end
    end
  end

end