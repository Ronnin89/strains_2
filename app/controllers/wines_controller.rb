class WinesController < ApplicationController
  before_action :authenticate_user!
    def index

        @wines = Wine.all.includes([:strains, :wine_strains])
        @wine = Wine.new
        @strains = Strain.all

    end
    
    def create
      
      @wine = Wine.new(wine_params)
      
      strain_ids = params[:wine][:strain_ids]
      strain_ids.delete("") unless strain_ids.nil?

      strain_percents = params[:wine][:strain_percent]
      strain_percents.delete("") unless strain_percents.nil?

      begin

        Wine.transaction do
          
          @wine.save
  
          strain_ids.length.times do |i|
  
            WineStrain.create(
              wine_id: @wine.id,
              strain_id: strain_ids[i],
              percent: strain_percents[i]
            )
  
          end
  
          flash[:alert] = "Wine agregado a la lista"
          redirect_to root_path
  
        end
      rescue

        flash[:alert] = "Verifica los datos entregados"
        redirect_to root_path

      end

    end

    def edit
      @wine = Wine.find(params[:id])
      @oenologists = Oenologist.all
    end

    private
    def wine_params
        params.require(:wine).permit(:name)
    end
end