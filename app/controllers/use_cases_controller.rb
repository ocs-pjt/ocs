class UseCasesController < ApplicationController
  before_action :set_use_case, only: [:show, :edit, :update, :destroy]

  # GET /use_cases
  # GET /use_cases.json
  def index
    @use_cases = UseCase.all
  end

  # GET /use_cases/1
  # GET /use_cases/1.json
  def show
  end

  # GET /use_cases/new
  def new
    @use_case = UseCase.new
  end

  # GET /use_cases/1/edit
  def edit
  end

  # POST /use_cases
  # POST /use_cases.json
  def create
    @use_case = UseCase.new(use_case_params)

    respond_to do |format|
      if @use_case.save
        format.html { redirect_to @use_case, notice: 'Use case was successfully created.' }
        format.json { render action: 'show', status: :created, location: @use_case }
      else
        format.html { render action: 'new' }
        format.json { render json: @use_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /use_cases/1
  # PATCH/PUT /use_cases/1.json
  def update
    respond_to do |format|
      if @use_case.update(use_case_params)
        format.html { redirect_to @use_case, notice: 'Use case was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @use_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /use_cases/1
  # DELETE /use_cases/1.json
  def destroy
    @use_case.destroy
    respond_to do |format|
      format.html { redirect_to use_cases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_use_case
      @use_case = UseCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:key, :user_id, :collector_id, :collector_version_id, :program_id, :program_version_id)
    end
end
