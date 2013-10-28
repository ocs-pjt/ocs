class TotosController < ApplicationController
  before_action :set_toto, only: [:show, :edit, :update, :destroy]

  # GET /totos
  # GET /totos.json
  def index
    @totos = Toto.all
  end

  # GET /totos/1
  # GET /totos/1.json
  def show
  end

  # GET /totos/new
  def new
    @toto = Toto.new
  end

  # GET /totos/1/edit
  def edit
  end

  # POST /totos
  # POST /totos.json
  def create
    @toto = Toto.new(toto_params)

    respond_to do |format|
      if @toto.save
        format.html { redirect_to @toto, notice: 'Toto was successfully created.' }
        format.json { render action: 'show', status: :created, location: @toto }
      else
        format.html { render action: 'new' }
        format.json { render json: @toto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /totos/1
  # PATCH/PUT /totos/1.json
  def update
    respond_to do |format|
      if @toto.update(toto_params)
        format.html { redirect_to @toto, notice: 'Toto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @toto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /totos/1
  # DELETE /totos/1.json
  def destroy
    @toto.destroy
    respond_to do |format|
      format.html { redirect_to totos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_toto
      @toto = Toto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def toto_params
      params.require(:toto).permit(:test, :titi, :tutu)
    end
end
