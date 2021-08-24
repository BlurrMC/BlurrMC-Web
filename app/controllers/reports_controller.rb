class ReportsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_reportable
    
    def create
        if @isituser != true
            if @isitvideo == true
                Report.create(recipient: @reportable.user, actor: current_user, reportable: @reportable, reportable_type: "Video")
                redirect_back(fallback_location: root_path)
            else
                Report.create(recipient: @reportable.user, actor: current_user, reportable: @reportable, reportable_type: "Comment")
                respond_to do |format|
                    format.js { render :comment }
                    format.html { redirect_back(fallback_location: root_path) }
                end
            end
        else
            Report.create(recipient: @reportable, actor: current_user, reportable: @reportable, reportable_type: "User")
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def find_reportable
        if params[:video_id]
            @reportable = Video.find(params[:video_id]) if params[:video_id]
            if params[:comment_id]
                @reportable = Comment.find(params[:comment_id])
            else
                @isitvideo = true
            end
        else
            @isitvideo = false
        end
        if params[:c_id]
            @reportable = User.friendly.find(params[:c_id])
            @isituser = true
        else
            @isituser = false
        end
    end
  end
  