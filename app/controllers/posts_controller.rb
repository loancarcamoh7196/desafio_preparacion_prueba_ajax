class PostsController < ApplicationController

    def index
        @post = Post.new
        respond_to do |format|
            if !params[:buscador].nil?
              if params[:buscador].blank? 
                
                @posts = Post.all
              elsif params[:buscador].length >=3
                @posts = Post.where('title LIKE ?', "%#{params[:buscador]}%")
              end
              format.js
            else
              @posts = Post.all
              format.html
            end
        end
    end

    def create
        @post = Post.new(post_params)
        @post.user_id = current_user.id

        respond_to do |format|
            if @post.save
                format.js
            else
                format.html { redirect_to posts_path, alert: 'Error. Intente nuevamente' }
            end
        end
    end

    def destroy
        @post = Post.find(params[:id])

        respond_to do |format|
            if @post.destroy
                format.js
            else
                format.html { redirect_to posts_path, alert: 'Error. Intente nuevamente' }
            end 
        end
    end
    
    def edit
        @post = Post.find(params[:id])
        respond_to { |format| format.js }
    end

    def update
        @post = Post.find(params[:id])
        respond_to do |format|
            if @post.update(post_params)
                format.js
            else
                format.html { redirect_to posts_path, alert: 'Error. Intente nuevamente' }
            end
        end
    end
    
    def show
        #@song = Song.find(params[:id])
        
        @post = Post.find(params[:id])
        
        respond_to do |format|
            format.js
        end
    end
    
    private 

    def post_params
        params.require(:post).permit(:title, :image, :content)
    end

end
