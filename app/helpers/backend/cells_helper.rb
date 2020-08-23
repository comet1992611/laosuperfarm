# == License
# Ekylibre - Simple agricultural ERP
# Copyright (C) 2014 Brice Texier
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
  module CellsHelper
    # No data permit to mark cell as empty
    def no_data
      # content_tag(:div, :no_data.tl, class: 'no-data')
      nil
    end

    def errored
      content_tag(:div, :internal_error.tl, class: 'internal-error')
    end
  end
end
