class JobsController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:index]

  def index

    jobs_collection = Job

    jobs_collection = jobs_collection.where('employer_id = ?', current_user) unless current_user.nil?

    num_days = params[:days].to_i
    jobs_collection = jobs_collection.where('date > ?', num_days.days.ago) if num_days > 0

    q1 = "%#{params[:keywords].to_s.downcase}%"
    jobs_collection = jobs_collection.where('(lower(title) like ? or lower(job_description) like ?)', q1, q1)

    unless params[:category].nil?
      q2 = "%#{params[:category].to_s.downcase}%"
      jobs_collection = jobs_collection.where('lower(category) like ?', q2)
    else
      q2 = "%#{params[:location].to_s.downcase}%"
      jobs_collection = jobs_collection.where('lower(location) like ?', q2)
    end

    page = params[:page].to_i 
    page = 1 if page == 0

    @jobs = jobs_collection.order('date DESC').paginate(:page => page, :per_page => 15)

    response = {
      total: @jobs.count,
      per_page: 15,
      page: page,
      items: @jobs
    }
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: response }
    end
  end

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(params[:job])

    @job.employer_id = current_user.id unless current_user.nil?

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
end
