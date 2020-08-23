# == License
# Ekylibre - Simple agricultural ERP
# Copyright (C) 2014 Brice Texier, David Joulin
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
  class GuidesController < Backend::BaseController
    manage_restfully

    unroll

    list(order: :name) do |t|
      t.action :run, method: :post
      t.action :edit
      t.action :destroy
      t.column :name, url: true
      t.column :active
      t.status
      t.column :stopped_at, through: :last_analysis, label: :checked_at, datatype: :datetime
      t.column :nature
      t.column :external
    end

    list(:analyses, model: :guide_analyses, conditions: { guide_id: 'params[:id]'.c }, order: { execution_number: :desc }) do |t|
      t.column :execution_number, url: true
      t.status
      t.column :started_at, hidden: true
      t.column :stopped_at
    end

    def run
      return unless @guide = find_and_check
      notify_warning(:implemented_with_dummy_data)
      @guide.run!
      redirect_to action: :show
    end
  end
end
