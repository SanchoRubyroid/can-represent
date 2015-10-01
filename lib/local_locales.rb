class LocalLocales
  EN_LOCALE = 'en'
  RU_LOCALE = 'ru'

  SUPPORTED_LOCALES = [
    EN_LOCALE,
    RU_LOCALE
  ]

  DEFAULT_LOCALE = EN_LOCALE

  class << self
    def is_supported?(locale)
      SUPPORTED_LOCALES.include?(locale.to_s.downcase)
    end

    def find(locale)
      SUPPORTED_LOCALES.detect{|loc| loc == locale.to_s.downcase} || DEFAULT_LOCALE
    end

    def each
      SUPPORTED_LOCALES.each {|locale| yield locale}
    end
  end
end