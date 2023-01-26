class ConjugationController < ApplicationController
  before_action :set_translation, only: %i[ show edit update destroy ]
  private

  # Use callbacks to share common setup or constraints between actions.
  def set_conjugation
    @conjugation = Conjugation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def conjugation_params
    params.require(:conjugation).permit(:present_i, :present_you, :present_hesheit, :present_we, :present_youall, :present_they)
  end
end
