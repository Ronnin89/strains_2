class WinesController < ApplicationController
    def index
        @wines = Wine.all
        @wine = Wine.new
        @strains = Strains.all
    end
    
    def create

        strains_ids = params[:wine][:strain_ids]
        strains_ids.delete("")

        strains = Strain.find(strain_ids)
        strains.each { |st| @wine.strains.push(st) }

        @wine = Wine.new(wine_params)
        if @wine.save
          flash[:success] = "Wine successfully created"
          redirect_to root_path
        else
          flash[:error] = "Something went wrong"
          redirect_to root_path
        end
    end
    
    private
    def wine_params
        params.require(:wine).permit(:name)
    end
end