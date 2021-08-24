class API::V1::ReportsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_reportable
    protect_from_forgery with: :null_session
    
    def create
        if @isituser != true
            if @isitvideo == true
                if !Report.exists?(reportable_id: @reportable, actor_id: current_user, reportable_type: "Video") && @repotrable.user != current_user
                    Report.create(recipient: @reportable.user, actor: current_user, reportable: @reportable, reportable_type: "Video")
                    render json: { status: 'Reported' }
                else
                    render json: { status: 'Already reported' }
                end
            else
                if !Report.exists?(reportable_id: @reportable, actor_id: current_user, reportable_type: "Comment") && @reportable.user != current_user
                    Report.create(recipient: @reportable.user, actor: current_user, reportable: @reportable, reportable_type: "Comment")
                    render json: { status: 'Reported' }
                else
                    render json: { status: 'Already reported' }
                end
            end
        else
            if !Report.exists?(reportable_id: @reportable, actor_id: current_user, reportable_type: "User") && @reportable != current_user
                Report.create(recipient: @reportable, actor: current_user, reportable: @reportable, reportable_type: "User")
                render json: { status: 'Reported' }
            else
                render json: { status: 'Already reported' }
            end
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
  