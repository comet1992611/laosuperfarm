# = Informations
#
# == License
#
# Ekylibre - Simple agricultural ERP
# Copyright (C) 2008-2009 Brice Texier, Thibaud Merigon
# Copyright (C) 2010-2012 Brice Texier
# Copyright (C) 2012-2019 Brice Texier, David Joulin
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
# along with this program.  If not, see http://www.gnu.org/licenses.
#
# == Table: deliveries
#
#  annotation              :text
#  created_at              :datetime         not null
#  creator_id              :integer
#  custom_fields           :jsonb
#  driver_id               :integer
#  id                      :integer          not null, primary key
#  lock_version            :integer          default(0), not null
#  mode                    :string
#  number                  :string
#  reference_number        :string
#  responsible_id          :integer
#  started_at              :datetime
#  state                   :string           not null
#  stopped_at              :datetime
#  transporter_id          :integer
#  transporter_purchase_id :integer
#  updated_at              :datetime         not null
#  updater_id              :integer
#

require 'test_helper'

class DeliveryTest < Ekylibre::Testing::ApplicationTestCase::WithFixtures
  test_model_actions
  # Add tests here...
end