module ApplicationHelper
  def count_category_posts(category_id)
    posts = Post.where(:category_id => category_id, :is_published => true)
    posts.count
  end
end
