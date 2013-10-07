class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  # GET /patients
  def index
    @patients = Patient.all
    @histories = History.all
  end

  # GET /patients/1
  def show
    @histories = @patient.histories.all
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit
    @histories = @patient.histories.all
  end

  # POST /patients
  def create
    @patient = Patient.new(patient_params)
    @patient.helped_by = "Eduardo Delgaldo"

    if @patient.save
      redirect_to @patient, notice: 'Patient was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /patients/1
  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /patients/1
  def destroy
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end

  def bulk_action
      params[:patients_records].each do |id|
          Patient.find(id).destroy
      end

      respond_to do |format|
        format.html { redirect_to users_path }
        format.json { head :no_content }
      end
  end

  def add_clinical_history
      @patient = Patient.find(params[:patient_id])
      @history = @patient.histories.create(:text => params[:text], :author => current_user.email)
      @history.set_created_at

      redirect_to patient_path(params[:patient_id])
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def patient_params
      params.require(:patient).permit(:firstname, :lastname, :telephone, :cellphone, :address, :id_card)
    end

    def history_params
      params.require(:history).permit(:text) if params[:history]
    end
end
