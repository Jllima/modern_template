# frozen_string_literal: true

module Posts
  class Update
    include UseCaseBase

    def initialize(post, params)
      @post = post
      @params = params
    end

    def call
      if @post.update(@params)
        success(@post)
      else
        failure(@post, @post.errors)
      end
    end
  end
end
