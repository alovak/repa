class WorksController < ApplicationController
  # GET /works
  # GET /works.xml
  def index
    
    if params[:status_id]
      @status_id = params[:status_id].to_i
      conditions = { :status => Status.new(@status_id) }
    end

    @works = Work.paginate :page => params[:page], :conditions => conditions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @works }
    end
  end

  # GET /works/1
  # GET /works/1.xml
  def show
    @work = Work.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work }
    end
  end

  # GET /works/1/edit
  def edit
    @work = Work.find(params[:id])
  end

  # PUT /works/1
  # PUT /works/1.xml
  def update
    @work = Work.find(params[:id])

    @work.attributes = params[:work]
    @work.owner = @current_user

    respond_to do |format|
      if @work.save
        flash[:notice] = 'Work was successfully updated.'
        format.html { redirect_to :action => :edit }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /works/1
  # DELETE /works/1.xml
  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to(works_url) }
      format.xml  { head :ok }
    end
  end
end
