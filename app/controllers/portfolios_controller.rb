# frozen_string_literal: true

class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[show edit update destroy]

  # GET /portfolios or /portfolios.json
  def index
    @portfolios = current_user.portfolios
  end

  # GET /portfolios/1 or /portfolios/1.json
  def show; end

  # GET /portfolios/new
  def new
    @portfolio = current_user.portfolios.build
    @portfolio.holdings.build
  end

  # GET /portfolios/1/edit
  def edit
    @portfolio.holdings.build if @portfolio.holdings.empty?
  end

  # POST /portfolios or /portfolios.json
  def create
    @portfolio = current_user.portfolios.build(portfolio_params)

    respond_to do |format|
      if @portfolio.save
        format.html { redirect_to portfolio_url(@portfolio), notice: 'Portfolio was successfully created.' }
        format.json { render :show, status: :created, location: @portfolio }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /portfolios/1 or /portfolios/1.json
  def update
    if @portfolio.update(portfolio_params)
      redirect_to @portfolio, notice: 'Portfolio was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /portfolios/1 or /portfolios/1.json
  def destroy
    @portfolio.destroy!

    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Custom actions to fetch stock data and dividends
  def fetch_stock_data
    ticker = params[:ticker]
    stock_data = PolygonService.fetch_stock_data(ticker)
    render json: stock_data
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def fetch_dividends
    ticker = params[:ticker]
    dividends = PolygonService.fetch_dividends(ticker)
    render json: dividends
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_portfolio
    @portfolio = Portfolio.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def portfolio_params
    params.require(:portfolio).permit(
      :name, holdings_attributes: %i[id shares ticker average_buy_price _destroy]
    )
  end

  def update_stock_data(ticker)
    PolygonService.update_stock_data(ticker)
  end
end
