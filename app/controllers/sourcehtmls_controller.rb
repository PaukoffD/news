class SourcehtmlsController < ApplicationController
  before_action :set_sourcehtml, only: [:show, :edit, :update, :destroy]

  def index
    @sourcehtml = Sourcehtml.all
  end

  def html
      @sources = Source.where(html: true)
   
  end

  def show
  end

  def new
    @source = Source.find(params[:id])
    @sourcehtml=Sourcehtml.new
  end

  def edit
    @source = Source.find(params[:id])
    #@sourcehtml = Sourcehtml.find_by_source_id(params[:id])
  end

  def create
    @source = Source.find(params[:id])
    @sourcehtml = Sourcehtml.new(sourcehtml_params)

    respond_to do |format|
      if @sourcehtml.save
        format.html { redirect_to @sourcehtml, notice: 'Source was successfully created.' }
        format.json { render :show, status: :created, location: @sourcehtml }
      else
        format.html { render :new }
        format.json { render json: @sourcehtml.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #@source = Source.find(params[:id])
    respond_to do |format|
      if @sourcehtml.update(sourcehtml_params)
        format.html { redirect_to @sourcehtml, notice: 'Source was successfully updated.' }
        format.json { render :show, status: :ok, location: @source }
      else
        format.html { render :edit }
        format.json { render json: @sourcehtml.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sourcehtml.destroy
    respond_to do |format|
      format.html { redirect_to sourceshtml_url, notice: 'Source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_sourcehtml
    @sourcehtml = Sourcehtml.find_by_source_id(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def sourcehtml_params
    params.require(:sourcehtml).permit!
  end
end
