class PostAuthoritiesController < ApplicationController
  
  before_filter :require_team_lead_user, :except => [ :get_auth ]
  
  def index
    @posts = PostAuthority.paginate(:per_page => 50, :page => params[:page] || 1, :order => 'status')
  end
  
  def get_auth
    
    @post = PostAuthority.find_by_permlink(params[:permlink])
    if @post.blank?
      if @new_post = PostAuthority.create({:title => params[:title], :permlink => params[:permlink], :rails_version => params[:rails_ver], :reference_module => params[:module]})
        render :json => {'authority' => @new_post.current_status}, :callback => params[:callback]  
      else
        render :status => 500, :head => 500
      end
    else
      render :json => {'authority' => @post.current_status}, :callback => params[:callback]  
    end
    
  end
  
  def bulk_process
    if request.xhr?
      post_ids = params[:posts].split(',').collect(&:to_i)
      @posts = PostAuthority.find(post_ids)
      if PostAuthority::STATUS_TOKENS.keys.include?(params[:new_status].to_i)
        @posts.each do |post|
          post.update_attribute(:status, params[:new_status])
        end
        new_status = PostAuthority::STATUS_TOKENS[params[:new_status].to_i]
        new_status_string = PostAuthority::STATUS_CODES[params[:new_status]]
        render :json => {"message" => "Great Success!", "new_status" => new_status, "new_status_string" => new_status_string}, :status => 200
      else
        render :json => {"message" => "Incorrect status, WHAT ARE YOU DOING!? :)"}.to_json
      end
    else
      logger.info "here"
      render :nothing => true, :status => 404
    end
  end
  
  def edit
    begin
      @post = PostAuthority.find(params[:id])
    rescue
      flash[:error] = "Unable to find that post"
      redirect_to post_authorities_url
    end
  end
  
  def update
    begin
      @post = PostAuthority.find(params[:post_authority][:id])
      if @post.update_attributes(params[:post_authority])
        flash[:notice] = "Post successfully updated"
        redirect_to post_authorities_url
      else
        flash[:error] = "Errors were found during saving"
        render :action => 'edit'
      end
    rescue
      flash[:error] = "Unable to update post"
      redirect_to post_authorities_url
    end
  end
end
