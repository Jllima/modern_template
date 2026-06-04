# frozen_string_literal: true

module Posts
  class Create
    include UseCaseBase

    def initialize(params)
      @params = params
    end

    def call
      post = Post.new(@params)

      if post.save
        success(post)
      else
        failure(post, post.errors)
      end
    end
  end
end
