# -*- encoding : utf-8 -*-
class IntervalsController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /intervals
  # GET /intervals.json
  def index
    @interval = current_user.opened_interval

    respond_to do |format|
      if @interval.nil?
        format.html { redirect_to new_interval_url }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_interval_url(@interval) }
        format.json { head :no_content }
      end
    end
  end

  # GET /intervals/1
  # GET /intervals/1.json
  def show
    @interval = current_user.intervals.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @interval }
    end
  end

  # GET /intervals/new
  # GET /intervals/new.json
  def new
    @interval = Interval.new

	@date = Date.today

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interval }
    end
  end

  # GET /intervals/1/edit
  def edit
    @interval = Interval.find(params[:id])

    redirect_to new_interval_url unless @interval.end.nil? || @interval.id == current_user.intervals.last.id

    @close_interval = true
    if !@interval.end.nil?
      @edit_date = true
      @page_title = 'Editar intervalo'
    else
      @interval.end = @interval.start
      @page_title = 'Marcar hora de saída'
    end
  end

  # OPEN
  # POST /intervals
  # POST /intervals.json
  def create
    @interval = Interval.new(params[:interval])
    @interval.user = current_user

    respond_to do |format|
      if @interval.save
        format.html { redirect_to @interval, notice: 'Interval was successfully created.' }
        format.json { render json: @interval, status: :created, location: @interval }
      else
        format.html { render action: "new" }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  # CLOSE
  # PUT /intervals/1
  # PUT /intervals/1.json
  def update
    @interval = Interval.find(params[:id])

    respond_to do |format|
      if @interval.update_attributes(params[:interval])
        format.html { redirect_to @interval, notice: 'Interval was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intervals/1
  # DELETE /intervals/1.json
  def destroy
    @interval = Interval.find(params[:id])
    if @interval.end.nil?
      redirect_url = intervals_url
    else
      redirect_url = list_intervals_url
    end
    
    @interval.destroy

    respond_to do |format|
      format.html { redirect_to redirect_url }
      format.json { head :no_content }
    end
  end
  
  # GET /intervals/retroactive
  def retroactive
	@interval = Interval.new
	@retroactive = true
    @edit_date = true
    respond_to do |format|
      format.html {render "new"}
      format.json { render json: @interval }
    end
  end
  
  # GET /intervals/all
  def list
     @intervals = current_user.intervals.order("start desc")

    respond_to do |format|
      format.html # list.html.erb
      format.json { render json: @intervals, :only=> [:start, :end, :amount] }
    end
  end
end
