#encoding: utf-8
class ClientsController < ApplicationController
  before_filter :authenticate_user!
  # GET /clients
  # GET /clients.json
  def index
    if params[:drop_filters] == '1' then
      session.clear
    end
    query_params = {}
    
    if params[:sort] != nil and Client.columns_hash.has_key?(params[:sort]) then
      @sort_column = params[:sort]
    else
      @sort_column = session[:sort] || 'id'
    end
    
    if (params[:sort] == nil and session[:sort] != nil) || (params[:filter] == nil and session[:filter_name] != nil) then
      flash.keep
      redirect_to clients_path ({:sort => session[:sort], 'filter[name]' => session[:filter_name]}) and return
    end
    
    session[:sort] = @sort_column
    query_params[:order] =  @sort_column + ' ASC'
    
    if  (params[:filter] != nil) and (!params[:filter]['name'].empty?) then
      session[:filter_name] = params[:filter]['name']
      @clients = Client.search_in_name(current_user.id, params[:filter]['name']).order(query_params[:order]).page(params[:page])
    else
      @clients = Client.find_user_items(current_user.id, {}).order(query_params[:order]).page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find_user_item(current_user.id, params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    
    @client = current_user.clients.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find_user_item(current_user.id, params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = current_user.clients.build(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: "Клиент #{@client.name} успешно добавлен" }
        format.json { render json: @client, status: :created, location: @client }
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find_user_item(current_user.id, params[:id]) 

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: "Клиент #{@client.name} успешно отредактирован" }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find_user_item(current_user.id, params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :ok }
    end
  end
end
