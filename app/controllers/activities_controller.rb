class ActivitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found

    def index
        render json: Activity.all, status: :ok
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.signups.destroy_all
        activity.destroy
        render json: activity
    end

    private
    
    def rescue_record_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end
end
