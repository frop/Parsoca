class TimeBanksController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /time_banks
  # GET /time_banks.json
  def index
    @time_banks = current_user.time_banks.order("date")
    @base_time_bank = current_user.basic.time_bank

    respond_to do |format|
      if @time_banks.nil?
        format.html { redirect_to new_time_bank_url }
        format.json { head :no_content }
      else
        format.html # index.html.erb
        format.json { render json: @time_bank }
      end
    end
  end

  # GET /time_banks/1
  # GET /time_banks/1.json
  def show
    @time_bank = TimeBank.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_bank }
    end
  end

  # GET /time_banks/new
  # GET /time_banks/new.json
  def new
    @time_bank = TimeBank.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_bank }
    end
  end

  # GET /time_banks/1/edit
  def edit
    @time_bank = TimeBank.find(params[:id])
    @time_bank['base'] = to_hours(@time_bank)
  end

  # POST /time_banks
  # POST /time_banks.json
  def create
    @time_bank = TimeBank.new(params[:time_bank])
    @time_bank.user = current_user

    respond_to do |format|
      if @time_bank.save
        format.html { redirect_to @time_bank, notice: 'Time bank was successfully created.' }
        format.json { render json: @time_bank, status: :created, location: @time_bank }
      else
        format.html { render action: "new" }
        format.json { render json: @time_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_banks/1
  # PUT /time_banks/1.json
  def update
    @time_bank = current_user.time_banks.find(params[:id])
    params[:time_bank]['base'] = TimeBank.from_hours(params[:time_bank]['base']);

    respond_to do |format|
      if @time_bank.update_attributes(params[:time_bank])
        format.html { redirect_to @time_bank, notice: 'Time bank was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_banks/1
  # DELETE /time_banks/1.json
  def destroy
    @time_bank = current_user.time_bank.find(params[:id])
    @time_bank.destroy

    respond_to do |format|
      format.html { redirect_to time_banks_url }
      format.json { head :no_content }
    end
  end
end
