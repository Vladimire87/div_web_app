# frozen_string_literal: true

json.array! @holdings, partial: 'holdings/holding', as: :holding
