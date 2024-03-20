# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :set_note, only: %i[show update destroy]
  before_action :authenticate_user!
  load_and_authorize_resource

  # GET /notes
  def index
    @notes = Note.where user: @current_user.id
    render json: @notes
  end

  # GET /notes/1
  def show
    render json: @note
  end

  # POST /notes
  def create
    @note = Note.new(note_params)
    @note.user = @current_user

    if @note.save
      render json: @note, status: :created
    else
      render json: { errors: @note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      render json: @note
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
  end

  # GET /all-notes
  # get all the notes for admin use
  def get_all_notes
    @notes = Note.all
    render json: { notes: @notes }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:title, :body)
  end
end
