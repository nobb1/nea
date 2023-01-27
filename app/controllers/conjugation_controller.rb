class ConjugationController < ApplicationController
  before_action :set_translation, only: %i[ show edit update destroy ]

  def new
    @conjugation = Conjugation.new
  end

  def create
    @conjugation = Conjugation.new(translation_params)

    respond_to do |format|
      if @conjugation.save
        format.html { redirect_to conjugation_url(@conjugation), notice: "Conjugation was successfully created." }
        format.json { render :show, status: :created, location: @conjugation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @conjugation.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_conjugation
    @conjugation = Conjugation.find(params[:id])
  end

  def conjugation_params
    params.require(:conjugation).permit(:present_i, :present_you, :present_hesheit, :present_we, :present_youall, :present_they)
  end
end
