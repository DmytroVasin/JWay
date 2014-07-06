module UploadPosts
  def add_posts
    Post.populate 20 do |post|
      post.title = Populator.words(2..6).titleize
      post.body_title = Populator.sentences(3)
      post.body = Populator.sentences(15)
      post.status = 2
      post.original = nil
    end
  end

  def add_user
    User.create({ email: 'nick-supernick@gmail.com', password: 'password' })
  end

  module_function :add_posts, :add_user
end
