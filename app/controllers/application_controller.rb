class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  def next_creation_url(character)
    return base_obligation_url(character) unless character.base_obligation?
    return character_obligations_url(character) unless character.obligations.any?
    return character_species_index_url(character) unless character.species?
    return character_url(character)
  end
end
