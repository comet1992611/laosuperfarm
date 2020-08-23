# == License
# Ekylibre - Simple agricultural ERP
# Copyright (C) 2008-2011 Brice Texier, Thibaud Merigon
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

module Backend
  class BuildingsController < Backend::ProductGroupsController
    list do |t|
      t.action :edit
      t.action :destroy
      t.column :name, url: true
      t.column :description
      # t.column :name, through: :parent, url: true
    end

    # Displays the main page with the list of buildings
    def index
      notify_now(:need_building_to_record_stock_moves) unless Building.any?
      super
    end

    # List divisions of a building
    list(:divisions, model: :product_memberships, conditions: { group_id: 'params[:id]'.c }, order: :started_at) do |t|
      t.column :name, through: :member, url: true
      t.column :started_at
      t.column :stopped_at
    end
  end
end
