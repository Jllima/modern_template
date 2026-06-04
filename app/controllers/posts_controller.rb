class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    result = Posts::Create.call(post_params)
    @post = result.data

    respond_to do |format|
      if result.success?
        format.html do
          redirect_to posts_url,
                      notice: "Post criado."
        end

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              "posts",
              partial: "posts/post",
              locals: {
                post: @post
              }
            ),
            turbo_stream.update("modal", "")
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    result = Posts::Update.call(@post, post_params)
    @post = result.data

    respond_to do |format|
      if result.success?
        format.html do
          redirect_to posts_url,
                      notice: "Post atualizado."
        end

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              @post,
              partial: "posts/post",
              locals: {
                post: @post
              }
            ),
            turbo_stream.update("modal", "")
          ]
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!

    respond_to do |format|
      format.html do
        redirect_to posts_url,
                    notice: "Post deletado."
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@post)
      end
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title,
      :desc
    )
  end
end
