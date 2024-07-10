# frozen_string_literal: true

json.array! @portfolios, partial: 'portfolios/portfolio', as: :portfolio
