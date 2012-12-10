class SpreadsController < ApplicationController
  before_filter :authenticate_user!
  # GET /spreads
  # GET /spreads.json
  def index
    @spreads = Spread.find_user_items(current_user.id).page(params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spreads }
    end
  end

  # GET /spreads/1
  # GET /spreads/1.json
  def show
    @spread = Spread.find_user_item(current_user.id, params[:id])
    @structure = JSON.parse(@spread.structure)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @spread }
    end
  end

  # GET /spreads/new
  # GET /spreads/new.json
  def new
    @spread = current_user.spreads.build
    @all_clients = Client.find_user_items(current_user.id, {}).collect {|item| [item.name, item.id]}
    @for_client = params[:client_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @spread }
    end
  end

  # GET /spreads/1/edit
  def edit
    @spread = Spread.find_user_item(current_user.id, params[:id])
    @all_clients = Client.find_user_items(current_user.id, {}).collect {|item| [item.name, item.id]}
  end

  # POST /spreads
  # POST /spreads.json
  def create
    @spread = current_user.spreads.build(params[:spread])
    @spread.client = Client.find_by_id(params[:spread][:client_id])
    @all_clients = Client.all.collect {|item| [item.name, item.id]}
    respond_to do |format|
      if @spread.save
        format.html { redirect_to @spread, notice: 'Spread was successfully created.' }
        format.json { render json: @spread, status: :created, location: @spread }
      else
        format.html { render action: "new" }
        format.json { render json: @spread.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /spreads/1
  # PUT /spreads/1.json
  def update
    @spread = Spread.find_user_item(current_user.id, params[:id])
    @spread.client = Client.find_by_id(params[:spread][:client_id])
    respond_to do |format|
      if @spread.update_attributes(params[:spread])
        format.html { redirect_to @spread, notice: 'Spread was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @spread.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spreads/1
  # DELETE /spreads/1.json
  def destroy
    @spread = Spread.find_user_item(current_user.id, params[:id])
    @spread.destroy

    respond_to do |format|
      format.html { redirect_to spreads_url }
      format.json { head :ok }
    end
  end
end
