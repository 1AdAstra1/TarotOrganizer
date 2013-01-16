#encoding: utf-8
class InterpretationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  # GET /interpretations
  # GET /interpretations.json
  def index
    @interpretations = Interpretation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @interpretations }
    end
  end

  # GET /interpretations/1
  # GET /interpretations/1.json
  def show
    @interpretation = Interpretation.find(params[:id])

    respond_to do |format|
      # нам не нужна страница для отдельной трактовки 
      format.html { redirect_to interpretations_path }
      format.json { render json: @interpretation }
    end
  end
  
  def by_code
    @interpretation = Interpretation.find_by_card_code(params[:code])

    respond_to do |format|
      format.json { render json: @interpretation }
    end
  end

  # GET /interpretations/new
  # GET /interpretations/new.json
  def new
    @interpretation = Interpretation.new
    @card_name = common_deck_structure[params[:card_code]] || not_found
    @card_code = params[:card_code];

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interpretation }
    end
  end

  # GET /interpretations/1/edit
  def edit
    @interpretation = Interpretation.find(params[:id])
    @card_name = common_deck_structure[@interpretation.card_code] || not_found
    @card_code = @interpretation.card_code;
  end

  # POST /interpretations
  # POST /interpretations.json
  def create
    @card_name = common_deck_structure[params[:interpretation][:card_code]] || not_found
    @card_code = params[:interpretation][:card_code];
    @interpretation = Interpretation.new(params[:interpretation])

    respond_to do |format|
      if @interpretation.save
        format.html { redirect_to interpretations_path, notice: 'Толкование успешно добавлено.' }
        format.json { render json: @interpretation, status: :created, location: @interpretation }
      else
        format.html { render action: "new" }
        format.json { render json: @interpretation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /interpretations/1
  # PUT /interpretations/1.json
  def update
    @interpretation = Interpretation.find(params[:id])

    respond_to do |format|
      if @interpretation.update_attributes(params[:interpretation])
        format.html { redirect_to interpretations_path, notice: 'Толкование успешно обновлено.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @interpretation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interpretations/1
  # DELETE /interpretations/1.json
  def destroy
    @interpretation = Interpretation.find(params[:id])
    @interpretation.destroy

    respond_to do |format|
      format.html { redirect_to interpretations_url }
      format.json { head :no_content }
    end
  end
end
