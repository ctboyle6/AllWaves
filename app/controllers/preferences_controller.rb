class PreferencesController < ApplicationController
  
  def index
    @preferences = Preference.all
  end

  def show
    @preference = Preference.find(params[:id])
  end

  def new
    @preference = Preference.new()
    
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private



end
