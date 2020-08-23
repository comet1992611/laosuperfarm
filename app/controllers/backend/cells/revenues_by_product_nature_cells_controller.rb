module Backend
  module Cells
    class RevenuesByProductNatureCellsController < Backend::Cells::BaseController
      def show
        @stopped_at = Time.zone.today.end_of_month
        @started_at = @stopped_at.beginning_of_month << 11
      end
    end
  end
end
