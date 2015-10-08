module ApplicationHelper
  def current_locale?(locale)
    locale.to_s.downcase == I18n.locale
  end

  def loginout_link
    (user_signed_in? ? link_to(t(:logout), destroy_user_session_path, method: :delete) : link_to(t(:login), new_user_session_path))
  end

  def global_menus
    GlobalMenu.each do |menu_container, menu_items|
      yield menu_container, menu_items
    end
  end
end
