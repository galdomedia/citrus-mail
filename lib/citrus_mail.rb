module CitrusMail
  HOST = 'https://app.freshmail.pl'
  ERRORS = {
      101 => 'niepoprawny klucz określający listę subskrypcyjną',
      102 => 'brak wymaganego pola email',
      103 => 'klucze identyfikujące pola dodatkowe nie należą do tej listy subskrypcyjnej',
      104 => 'klucz identyfikujący api jest niepoprawny',
      201 => 'podany email jest już zapisany do danej listy subskrypcyjnej',
      202 => 'podany adres email jest niepoprawny',
      203 => 'długość znaków dla pól dodatkowych, bądź nazwy została przekroczona',
      204 => 'podane kodowanie znaków jest nieprawidłowe',
      205 => 'dane wprowadzone od pól dodatkowych przekraczają dozwoloną długość 255 znaków',
      206 => 'nie ma takiego subskrybenta',
      207 => 'niepoprawne kodowanie',
      999 => 'błąd połączenia do bazy danych'
  }

  class CitrusMailError < StandardError
    def initialize(code_or_message=nil)
      if code_or_message.is_a?(Fixnum)
        code_or_message = "#{code_or_message} - #{CitrusMail::ERRORS[code_or_message] || "Unknown error"}"
      end
      super(code_or_message)
    end
  end

  #raised when http request is failed
  class RequestFailed < CitrusMailError

  end

  #raised when api key is invalid (FreshMail return code 104)
  class InvalidAPIKey < CitrusMailError

  end

  #raised when list key is invalid (FreshMail return code 101)
  class InvalidListKey < CitrusMailError

  end

  #raised when email is invalid (FreshMail return code 202)
  class InvalidEmail < CitrusMailError

  end

  #raised when email already exists for list (FreshMail return code 201)
  class EmailExists < CitrusMailError

  end

  #raised when subscriber not exists (FreshMail return code 206)
  class SubscriberNotExists < CitrusMailError

  end
end

require 'citrus_mail/client'
require 'citrus_mail/list'
require 'citrus_mail/response'

# jtidhzdxlp

#require 'citrus_mail'
#cm = CitrusMail::Client.new('0633bb5ff7191ff48c4f065aa17f0321')
#list = cm.get_list('hi03a662gw')
#r = list.add_subscriber('piotr@galdomedia.pl')
