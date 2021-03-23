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
    end
    

    def update
          @wine = Wine.find(params[:id])
          if @wine.update(name: wine_params[:name])
  
          percent = wine_params[:percent]
          percent.delete("") unless percent.nil?

          oenologist_ids = wine_params[:oenologist_ids]
          oenologist_ids.delete("") unless oenologist_ids.nil?

          score = wine_params[:score]
          score.delete("") unless score.nil?

          for i in 0...(oenologist_ids.count) do
            WineOenologist.create(oenologist_id: oenologist_ids[i], wine_id: @wine.id, score: score[i])
          end  
 

            flash[:alert] = "Nota agregada agregado a la lista"
            redirect_to root_path

        else

            flash[:alert] = "Verifica los datos entregados"
            redirect_to root_path
            
        end
      
    end

    private
    def wine_params
        params.require(:wine).permit(:name, strain_ids:[], percent:[], oenologist_ids:[], score:[])
    end

end