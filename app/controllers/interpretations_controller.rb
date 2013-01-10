class InterpretationsController < ApplicationController
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
      format.html # show.html.erb
      format.json { render json: @interpretation }
    end
  end

  # GET /interpretations/new
  # GET /interpretations/new.json
  def new
    @interpretation = Interpretation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @interpretation }
    end
  end

  # GET /interpretations/1/edit
  def edit
    @interpretation = Interpretation.find(params[:id])
  end

  # POST /interpretations
  # POST /interpretations.json
  def create
    @interpretation = Interpretation.new(params[:interpretation])

    respond_to do |format|
      if @interpretation.save
        format.html { redirect_to @interpretation, notice: 'Interpretation was successfully created.' }
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
        format.html { redirect_to @interpretation, notice: 'Interpretation was successfully updated.' }
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
