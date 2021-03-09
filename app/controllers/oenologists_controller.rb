class OenologistsController < ApplicationController
    def new
        @oenologist = Oenologist.new
    end
    
    def create
        @oenologist = Oenologist.new(oenologist_params)
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
        params.require(:oenologist).permit(:name, :age, :nationality, :editor, :writer, :reviewer)
    end
    
end