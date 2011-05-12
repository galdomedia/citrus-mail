module CitrusMail
  class List
    attr_accessor :key, :client, :response

    def initialize(client_or_api_key, key)
      @key = key
      if client_or_api_key.is_a?(CitrusMail::Client)
        @client = client_or_api_key
      else
        @client = CitrusMail::Client.new(client_or_api_key)
      end
    end

    def add_subscriber(email, name=nil, custom_fields={}, options={:confirm_email => true})
      params = {:freshmail_email => email}
      params[:freshmail_name] = name if name
      params[:freshmail_custom_field] = custom_fields if custom_fields.empty?
      unless options[:confirm_email].nil?
        params[:confirm_email] = options[:confirm_email]
      end

      path = client.path_for(:add_subscriber)
      make_post_request(path, params)
    end

    def confirm(identifier)
      params = {:freshmail_subscriber => identifier}

      path = client.path_for(:confirm)
      make_get_request(path, params)
    end

    def add_and_confirm_subscriber(email, name=nil, custom_fields={}, options={})
      options[:confirm_email] = false
      add_subscriber(email, name, custom_fields, options)
      confirm(email)
    end

    def modify_subscriber(email, fields={})
      params = {:freshmail_subscriber => email}
      if name = fields.delete(:name)
        params[:freshmail_name] = name
      end
      params[:freshmail_custom_field] = fields unless fields.empty?

      path = client.path_for(:modify)
      make_post_request(path, params)
    end

    #4 – subskrybent wypisany
    #6 – subskrybent skasowany
    def change_state(identifier, state)
      params = {:freshmail_subscriber => identifier, :state => state}

      path = client.path_for(:change_state)
      make_post_request(path, params)
    end

    def get_empty_fields(email)
      params = {:freshmail_subscriber => email}

      path = client.path_for(:get_empty_fields)
      make_get_request(path, params)
    end

    def remove(identifier)
      params = {:freshmail_subscriber => identifier}

      path = client.path_for(:remove)
      make_get_request(path, params)
    end

    protected

    def make_post_request(path, params)
      self.response = nil
      params = {:freshmail_list => key}.merge(params)
      self.response = client.http_post(path, params)
      response.code
    end

    def make_get_request(path, params)
      self.response = nil
      params = {:freshmail_list => key}.merge(params)
      self.response = client.http_get(path, params)
      response.code
    end

  end
end