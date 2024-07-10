# frozen_string_literal: true

class HoldingsController < ApplicationController
  before_action :set_holding, only: %i[show edit update destroy]

  # GET /holdings or /holdings.json
  def index
    @holdings = Holding.all
  end

  # GET /holdings/1 or /holdings/1.json
  def show; end

  # GET /holdings/new
  def new
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.new
    @stocks = Stock.all
  end

  # GET /holdings/1/edit
  def edit; end

  # POST /holdings or /holdings.json
  def create
    @portfolio = Portfolio.find(params[:portfolio_id])
    @holding = @portfolio.holdings.new(holding_params)

    respond_to do |format|
      if @holding.save
        format.html { redirect_to  @portfolio, notice: 'Holding was successfully created.' }

      else
        @stocks = Stock.all
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holdings/1 or /holdings/1.json
  def update
    respond_to do |format|
      if @holding.update(holding_params)
        format.html { redirect_to holding_url(@holding), notice: 'Holding was successfully updated.' }
        format.json { render :show, status: :ok, location: @holding }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holdings/1 or /holdings/1.json
  def destroy
    @holding.destroy!

    respond_to do |format|
      format.html { redirect_to holdings_url, notice: 'Holding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_holding
    @holding = Holding.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def holding_params
    params.require(:holding).permit(:shares, :stock_id, :average_buy_price)
  end
end
