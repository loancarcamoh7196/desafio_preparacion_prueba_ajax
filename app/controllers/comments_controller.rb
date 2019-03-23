class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
        @comment.post_id = params[:post_id]
        
            @comment.save
                respond_to :js
        

        # if @comment.save
        #     redirect_to posts_path
        # else
        #     redirect_to posts_path, alert: 'Error. Intente nuevamente' 
        # end
    end
    
    private

    def comment_params
        params.require(:comment).permit(:content, :post_id, :user_id)
    end
    
end
