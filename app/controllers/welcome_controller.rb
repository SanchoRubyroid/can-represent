class WelcomeController < ApplicationController
  def index
  end

  def change_locale
    fail 'Invalid locale' unless LocalLocales.is_supported?(params[:locale])

    store_locale
    set_locale

    redirect_to :back
  end
end
