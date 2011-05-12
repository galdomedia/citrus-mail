module CitrusMail
  class Response
    attr_accessor :http_response, :code, :freshmail_response

    def self.build_from_http_response(http_response)
      response = self.new()
      response.http_response = http_response
      response.process_http_response
      response
    end

    def process_http_response
      if http_response.code.to_i == 200 and res = (r = http_response.body.match(/\<response\>(.*)\<\/response\>/) and r[1])
        self.freshmail_response = res
        self.code = res.to_i
        if code > 100
          raise InvalidListKey.new(code) if code == 101
          raise InvalidAPIKey.new(code) if code == 104
          raise EmailExists.new(code) if code == 201
          raise InvalidEmail.new(code) if code == 202
          raise SubscriberNotExists.new(code) if code == 206

          raise CitrusMailError.new(code)
        end
      else
        raise RequestFailed
      end
    end

    def parse_json_freshmail_response
      ActiveSupport::JSON.decode freshmail_response
    end

  end
end