class PostAuthoritiesController < ApplicationController
  
 # before_filter :require_team_lead_user, :except => [ :create, :process ]
  
  def index
    @posts = PostAuthority.paginate(:per_page => 50, :page => params[:page] || 1)
  end
  
  def get_auth
    @post = PostAuthority.find_by_permlink(params[:permlink])
    if @post.blank?
      if @post = PostAuthority.create({:title => params[:title], :permlink => params[:permlink]})
        render :json => {'authority' => @post.current_status}, :callback => params[:callback]  
      else
        render :status => 500, :head => 500
      end
    else
      render :json => {'authority' => @post.current_status}, :callback => params[:callback]  
    end
    
  end

end
