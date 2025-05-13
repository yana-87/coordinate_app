class CoordinatesController < ApplicationController
  before_action :set_coordinate, only: %i[ show edit update destroy ]

  # GET /coordinates or /coordinates.json
  def index
    @coordinates = Coordinate.with_attached_image
                             .where.not(id: Coordinate.left_outer_joins(:image_attachment)
                                                       .where(active_storage_attachments: { id: nil }))
                             .page(params[:page]).per(10)
  end


  # GET /coordinates/1 or /coordinates/1.json
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /coordinates/new
  def new
    @coordinate = Coordinate.new
  end

  # GET /coordinates/1/edit
  def edit
  end

  # POST /coordinates or /coordinates.json
  def create
    @coordinate = Coordinate.new(coordinate_params)

    respond_to do |format|
      if @coordinate.save
        format.html { redirect_to @coordinate, notice: "Coordinate was successfully created." }
        format.json { render :show, status: :created, location: @coordinate }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coordinate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coordinates/1 or /coordinates/1.json
  def update
    respond_to do |format|
      if @coordinate.update(coordinate_params)
        format.html { redirect_to @coordinate, notice: "Coordinate was successfully updated." }
        format.json { render :show, status: :ok, location: @coordinate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coordinate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coordinates/1 or /coordinates/1.json
  def destroy
    @coordinate.destroy!

    respond_to do |format|
      format.html { redirect_to coordinates_path, status: :see_other, notice: "Coordinate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coordinate
      @coordinate = Coordinate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coordinate_params
      params.require(:coordinate).permit(:title, :memo, :image)
    end
end
