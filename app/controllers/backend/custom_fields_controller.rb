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
  class CustomFieldsController < Backend::BaseController
    manage_restfully active: true, nature: :text
    manage_restfully_list
    unroll

    list(order: 'customized_type, position') do |t|
      t.action :up, method: :post, unless: :first?
      t.action :down, method: :post, unless: :last?
      t.action :edit
      t.action :destroy, if: :destroyable?
      t.column :name, url: true
      t.column :customized_type
      t.column :nature
      t.column :required
      t.column :active
      t.column :choices_count, datatype: :integer
    end

    list(:choices, model: :custom_field_choices, conditions: { custom_field_id: 'params[:id]'.c }, order: 'position') do |t|
      t.action :up, unless: :first?, method: :post
      t.action :down, unless: :last?, method: :post
      t.column :name
      t.column :value
    end

    # Sort.all choices by name
    def sort
      return unless @custom_field = find_and_check
      @custom_field.sort_choices!
      redirect_to params[:redirect] || { action: :index }
    end
  end
end
