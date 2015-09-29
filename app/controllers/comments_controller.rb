class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable

  def create
    # @comment = @commentable.comments.new comment_params
    @comment             = Comment.new comment_params
    @comment.commentable = @commentable
    if @comment.save
      redirect_to @commentable, notice: "Comment created!"
    else
      folder_name = @commentable.class.name.underscore.pluralize
      render "#{folder_name}/show"
    end
  end

  private

  def find_commentable
    if params[:campaign_id]
      @commentable = Campaign.find(params[:campaign_id])
      @campaign    = @commentable.decorate
    elsif params[:discussion_id]
      @discussion = @commentable = Discussion.find params[:discussion_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
