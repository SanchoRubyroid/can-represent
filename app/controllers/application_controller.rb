class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :initialize_for_layout

  before_action :set_locale, :test_menus

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
  end

  def test_menus
    @global_menus = {
      menu_1:[
        { caption: 'Cap11',
          path: root_path },
        { caption: 'Cap12',
          path: root_path },
        { caption: 'Cap13',
          path: root_path }
      ],
      menu_2:[
        { caption: 'Cap21',
          path: root_path },
        { caption: 'Cap22',
          path: root_path }
      ]
    }
  end
end
