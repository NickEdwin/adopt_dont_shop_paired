class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :favorite

  def favorite
    session[:fav_pets] ||= []
    Favorite.new(session[:fav_pets])
  end

end
