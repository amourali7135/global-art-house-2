class JobsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show ]

  def index
    if params["search"] #reject '' in middle added 112619
      @filter = params["search"]["tag_list"].concat([params['country']]).concat([params["search"]["city"]]).concat([params["search"]["title"]]).concat([params["search"]["description"]]).concat([params["search"]["requirements"]]).concat([params["search"]["salary"]]).concat([params["search"]["remote"]]).concat([params["search"]["company"]]).concat([params["search"]["seniority"]]).concat([params["search"]["industry"]]).concat([params["search"]["benefits"]]).concat([params["search"]["why"]]).concat([params["search"]["frequency"]]).concat([params["search"]["preferred"]]).concat([params["search"]["active"]]).flatten.reject(&:blank?)
      @jobs = Job.global_search(@filter).includes([:taggings]).paginate(page: params[:page], per_page: 20)

    else #112619 I added this while trying to get sort to work.
      @jobs = Job.includes([:taggings]).paginate(page: params[:page], per_page: 20)
      # @jobs = Job.all
    end

    #params[:search][:sorted_by] == "" by default...
    # if params[:search] && params[:search][:sorted_by] #first part added experimental, not originally.
    if params[:search] && params[:search][:sorted_by] && params[:search][:sorted_by] != ''
      if params[:search][:sorted_by] == 'most_likes'
        # @jobs = Job.global_search(@filter).sort_by { |job| -job.get_likes.size }
        @jobs = @jobs.sort_by { |job| -job.get_likes.size }
        # @jobs.order('get_likes.size DESC')
        #paginate here
      end
      if params[:search][:sorted_by] == 'most_viewed'
        # @jobs = Job.global_search(@filter).sort_by { |job| -job.hits }
        @jobs = @jobs.sort_by { |job| -job.hits }
        #paginate here
      end
      if params[:search][:sorted_by] == 'most_recent'
        # @jobs = Job.global_search(@filter).sort_by { |job| -job.id }
        @jobs = @jobs.sort_by { |job| -job.id }
        #paginate here
      end
      if params[:search][:sorted_by] == 'most_followed'
        # @jobs = Job.global_search(@filter).sort_by { |job| -job.id }
        @jobs = @jobs.sort_by { |job| -job.followers_count }
        #paginate here
      end
      #paginate here
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    if @job.save
      flash[:notice] = "Your job posting was successfully created!"
      redirect_to dashboard_path
    else
      render "new"
    end
    raise

  end

  def show
    @user = current_user
    @job = Job.find(params[:id])
    @job.punch(request)
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      flash[:notice] = "Your job posting was successfully updated!"
      redirect_to dashboard_path
    else
      flash[:error] = "There was an error, please try again!"
      render 'edit'
    end
  end

  def delete  #delete or destroy...
    # @job = Job.find(params[:id])
    @job = Job.find(params[:id])
    @job.destroy
    flash[:notice] = "Your job posting was successfully deleted!"
    redirect_to dashboard_path
  end

  def edit
    @category = ['Painting', 'Drawing', 'Sculpting', 'Architecture', 'Ceramics', 'Electronic', 'Light', 'Graphic', 'Photography', 'Textile', 'Performance', 'Poetry', 'Literature', 'Collage', 'Digital', 'Animation', 'Body', 'Street', 'Graffiti', 'Glass', 'Tapestry', 'Installation', 'Calligraphy', 'Dance', '' ].sort
    # @job = Job.find(params[:id])
    @job = Job.find(params[:id])
  end

  def like
    @user = current_user # before_action :authenticate_user, only: [:likes]
    # @job = Job.find(params[:id])
    @job = Job.find(params[:id])
    @job.liked_by @user
    redirect_to @job, notice: "Liked this job successfully!"
  end

  def unlike
    @user = current_user # before_action :authenticate_user, only: [:likes]
    # @job = Job.find(params[:id])
    @job = Job.friendly.find(params[:id])
    @job.unliked_by @user
    redirect_to @job, notice: "Unliked this job successfully!"
  end

  private

  def job_params
    params.require(:job).permit( :title, :description, :requirements, :salary, :remote, :photo, :city, :country, :longitude, :latitude, :company, :seniority, :industry, :benefits, :why, :frequency, :preferred, :active, :user, :user_id, tag_list: [] )
  end

end
