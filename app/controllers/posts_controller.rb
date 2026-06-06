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

    return render_form_errors(:new) unless result.success?

    respond_with_success(
      url: posts_url,
      notice: "Post criado com sucesso.",
      action: :create,
      record: @post
    )
  end

  def update
    result = Posts::Update.call(@post, post_params)
    @post = result.data

    return render_form_errors(:edit) unless result.success?

    respond_with_success(
      url: posts_url,
      notice: "Post atualizado com sucesso.",
      action: :update,
      record: @post
    )
  end

  def destroy
    @post.destroy!

    respond_with_success(
      url: posts_url,
      notice: "Post deletado com sucesso.",
      action: :destroy,
      record: @post
    )
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
