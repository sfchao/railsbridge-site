class DocumentsController < ApplicationController

  before_filter :require_team_lead_user, :except => [ :index, :show ]
  before_filter :find_document, :only => [ :show, :edit, :update, :destroy ]

  def index
    @documents = Document.all(:order => "updated_at DESC")
    @page_title = "RailsBridge Documents"
  end

  def show
    @page_title = @document.name
  end

  def new
    @document = Document.new
    @page_title = "New RailsBridge Document"
  end

  def edit
    @page_title = "Edit #{@document.name}"
  end

  def create
    @document = Document.new(params[:document])
    @document.user = current_user

    if @document.save
      flash[:notice] = 'Document was successfully created.'
      redirect_to(@document)
    else
      render :action => "new"
    end
  end

  def update
    if @document.update_attributes(params[:document])
      flash[:notice] = 'Document was successfully updated.'
      redirect_to(@document)
    else
      render :action => "edit"
    end
  end

  def destroy
    @document.destroy
    flash[:notice] = 'Document was deleted.'
    redirect_to(documents_url)
  end
  
private

  def find_document
    @document = Document.find(params[:id])
  end
end
