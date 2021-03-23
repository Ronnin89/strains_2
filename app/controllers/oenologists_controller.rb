class OenologistsController < ApplicationController
  before_action :authenticate_user!
    def new
        @oenologist = Oenologist.new
        @magazines = Magazine.all
    end
    
    def create
        @oenologist = Oenologist.new(name: oenologist_params[:name], age: oenologist_params[:age], nationality: oenologist_params[:nationality])

        oenologist_magazine = oenologist_params[:magazine_ids]
        oenologist_magazine.delete("") unless oenologist_magazine.nil?

        magazine_position = oenologist_params[:position]
        magazine_position.delete("") unless magazine_position.nil?

        for i in 0...(oenologist_magazine.count) do
          MagazineOenologist.create(oenologist_id: @oenologist.id, magazine_id: oenologist_magazine[i], position: magazine_position[i])
        end

        if @oenologist.save
          flash[:success] = "Oenologist successfully created"
          redirect_to root_path
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end
    
    private
    def oenologist_params
        params.require(:oenologist).permit(:name, :age, :nationality, magazine_ids: [],position: [])
    end
    
end