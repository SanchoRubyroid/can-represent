module ApplicationHelper
  def current_locale?(locale)
    locale.to_s.downcase == I18n.locale
  end
end
