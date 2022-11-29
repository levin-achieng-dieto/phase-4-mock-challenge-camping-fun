class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :rescue_record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :render_ivalid_entity_response

    def index
        render json: Camper.all, status: :ok
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer
    end

    def create
        camper = Camper.create!(create_camper)
        render json: camper, status: :created
    end

    private

    def create_camper
        params.permit(:name, :age)
    end

    def rescue_record_not_found
        render json: {error: "Camper not found"}, status: :not_found
    end

    def render_ivalid_entity_response(invalid) 
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
