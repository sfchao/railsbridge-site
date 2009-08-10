class PostAuthoritiesController < ApplicationController
  
 # before_filter :require_team_lead_user, :except => [ :create, :process ]
  
  def index
    @posts = PostAuthority.paginate(:per_page => 50, :page => params[:page] || 1)
  end
  
  def get_auth
    logger.info "params: #{params.inspect}"
    @post = PostAuthority.find_by_permlink(params[:permlink])
    if @post.blank?
      if @post = PostAuthority.create({:title => params[:title], :permlink => params[:permlink], :rails_version => params[:rails_ver], :reference_module => params[:module]})
        render :json => {'authority' => @post.current_status}, :callback => params[:callback]  
      else
        render :status => 500, :head => 500
      end
    else
      render :json => {'authority' => @post.current_status}, :callback => params[:callback]  
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
