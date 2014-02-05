class DescriptionsController < ApplicationController
  layout 'characters'

  skip_before_filter :verify_authenticity_token

  def edit
    @character = current_user.characters.find(params[:id])
    @species_images = %w{ None AQUA ARKAN ARKANOFF BARAB BITH BOTH CAAMASI CATHAR CEREAN CHADRA CHISS CLAWDITE DASHADE DEFEL DEVAR DROID DUG DUROS EWOK FALLEEN FARGHUL GAMORREAN GAND GIVIN GOTAL GRAN GUNGAN HERGLIC HUMAN ITHORIAN JAWA KLATOO KUBAZ MONCAL NAGAI NAUTOLAN NEIM NIKTO NOGHRI ORTOLAN QUARREN ROD RYN SELKATH SHIST SLUISSI SNIVVIAN SQUIB SULLUSTAN TOGORIAN TOGRUTA TOYDARIAN TRAND TWI VERPINE WEEQUAY WHIPHID WOOK ZABRAK ZELTRON }.map do |image|
      image.capitalize
    end
  end

  def portrait
    @character = current_user.characters.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @character = current_user.characters.find(params[:id])

    if params[:portrait_url].present?
      @character.portrait = URI.parse(params[:portrait_url])
    end

    if params[:stock_portrait] != "None"
      species = params[:stock_portrait].upcase
      url = view_context.asset_url("/assets/species/#{species}.png")
      @character.portrait = URI.parse(url)
    end

    if @character.update_attributes(character_params)
      flash[:notice] = "Your character has been updated."
    else
      flash[:notice] = "There was a problem updating your character."
    end

    redirect_to edit_description_url(@character)
  end

  def character_params
    params.require(:character).permit(:name, :player_name, :gender, :age, :height, :build, :hair,
      :eyes, :notable_features, :credits, :earned_experience, :portrait, :portrait_url)
  end
end
