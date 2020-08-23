module Backend
  module Cells
    class MapCellsController < Backend::Cells::BaseController
      def show
        @campaigns = if params[:campaign_ids]
                       Campaign.find(params[:campaign_ids])
                     elsif params[:campaign_id]
                       Campaign.find(params[:campaign_id])
                     else
                       current_campaign
                     end

        @activity_production_ids = params[:activity_production_ids] if params[:activity_production_ids]
        @activity_production_ids = params[:activity_production_id] if params[:activity_production_id]

        @url_params = {
          activity_production_ids: @activity_production_ids,
          campaigns: @campaigns,
          visualization: params[:visualization]
        }

        @activity_productions = (@activity_production_ids ? ActivityProduction.where(id: @activity_production_ids) : ActivityProduction.of_campaign(@campaigns)).where.not(support_shape: nil)
      end
    end
  end
end
