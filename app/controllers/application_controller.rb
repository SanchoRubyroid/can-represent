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

  def after_sign_in_path_for(resource)
    sign_in_url = new_user_session_url
    if request.referer == sign_in_url
      admin_home_path
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def store_locale
    cookies[:locale] = params[:locale]
    current_user.try(:update_column, :locale, cookies[:locale])
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def initialize_for_layout
    @menu_manager = GlobalMenu::Manager.new

    @menu_manager.for_container(t('menu.admin'), admin_home_path) do |admin_container|
      admin_container << GlobalMenu::Item.new(t('menu.console'), admin_console_path)
    end if user_signed_in?
  end
end
