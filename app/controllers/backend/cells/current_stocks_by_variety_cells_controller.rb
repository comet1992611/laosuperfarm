module Backend
  module Cells
    class CurrentStocksByVarietyCellsController < Backend::Cells::BaseController
      def show
        @variety = params[:variety] || :product
        @indicator = Nomen::Indicator[params[:indicator] || :net_mass]
        @unit = Nomen::Unit[params[:unit] || @indicator.unit]
      end
    end
  end
end
