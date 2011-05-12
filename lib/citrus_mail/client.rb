require 'net/http'
require 'net/https'

module CitrusMail
  class Client
    attr_accessor :api_key, :encoding

    def initialize(api_key, options={})
      @api_key = api_key
      @encoding = options[:encoding] if options[:encoding]
    end

    def get_list(key)
      List.new(self, key)
    end

    #actions = [modify, get_empty_fields, change_state, confirm, remove, add_subscriber]
    def path_for(action)
      "/main.php?moduleName=fm_api&action=#{action}"
    end

    def connection
      @connection ||= begin
        uri = URI.parse(HOST)
        connection = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == "https" # enable SSL/TLS
          connection.use_ssl = true
          connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        connection
      end
    end

    def http_get(url, params)
      response = connection.start do |http|
        url_with_params = url + "&" + process_params(params).map { |k, v| "#{urlencode(k.to_s)}=#{urlencode(v.to_s)}" }.join('&')
        get = Net::HTTP::Get.new(url_with_params)
        http.request(get)
      end
      Net::HTTPOK
      CitrusMail::Response.build_from_http_response(response)
    end

    def http_post(path, params)
      response = connection.start do |http|
        post = Net::HTTP::Post.new(path)
        post.set_form_data(process_params(params))
        http.request(post)
      end
      CitrusMail::Response.build_from_http_response(response)
    end

    def process_params(params)
      hash = {:api_key => api_key}
      hash[:encoding] = @encoding if @encoding
      hash.merge!(params)
      flatten_params(hash)
    end

    def flatten_params(params)
      params.inject({}) do |h, (key, value)|
        if value.is_a?(Hash)
          value.each_pair { |k, v| h["#{key}[#{k}]"] = v.to_s }
        else
          h[key] = value.to_s
        end
        h
      end
    end

    #copied from ''net/http'
    def urlencode(str)
      str.gsub(/[^a-zA-Z0-9_\.\-]/n) { |s| sprintf('%%%02x', s[0]) }
    end

  end
end