class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :initialize_for_layout

  before_action :set_locale

  def set_locale
    I18n.locale = current_user.try(:locale) || cookies[:locale] || LocalLocales.find(extract_locale_from_accept_language_header)
  end

  private

  def store_locale
    cookies[:locale] = params[:locale]
    current_user.try(:update_column, :locale, cookies[:locale])
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def initialize_for_layout
    # Override me
  end
end
