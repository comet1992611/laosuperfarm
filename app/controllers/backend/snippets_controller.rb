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
  class SnippetsController < Backend::BaseController
    # Saves the state of the side snippets
    def toggle
      collapsed = !params[:collapsed].to_i.zero?
      snippet = params[:id].to_s.strip
      if snippet.blank?
        head :not_found
      else
        p = current_user.preference("interface.snippets.#{snippet}.collapsed", false, :boolean)
        p.set!(collapsed)
        head :ok
      end
    end
  end
end
