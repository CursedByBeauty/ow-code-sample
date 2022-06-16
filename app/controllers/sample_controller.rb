class SampleController < ApplicationController
    def index
        @csv = User.all
        @import = User::Import.new

        respond_to do |format|
            format.html
            format.csv { send_data @csv.to_json }
    end
    def import 
        @import = User::Import.new user_import_para:missing
        if @import.save
            redirect_to users_path, notice: "Imported #{@import.imported_count} csv"
        else
            @csv = User.all
            flash[:alert] = "There were #{@import.errors.count} errors with your CSV file"
        end
    end

    private 
        def user_import_params
            params.require(:user_import).permit(:file)
        end
end