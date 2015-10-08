class Admin::BaseController < ApplicationController
  before_action :authenticate_user!, :initialize_for_layout

  def initialize_for_layout
    super

    @menu_manager.for_container('Admin', admin_home_path) do |admin_container|
      admin_container << GlobalMenu::Item.new('Console', admin_console_path)
    end
  end
end