xml.instruct!
xml.rss :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' do

  xml.channel do
    xml.title 'Feed title'
    xml.description 'Feed description'
    xml.link root_url
    xml.language 'en'
    xml.tag! 'atom:link', :rel => 'self', :type => 'application/rss+xml', :href => posts_url

    for post in @posts
      xml.item do
        xml.title post.title
        xml.category post.category.name
        xml.tags post.tag_list.map { |t| t }.join(', ')
        xml.pubDate(post.created_at.rfc2822)
        xml.link post_url(post)
        xml.guid post_url(post)
        xml.description(h(post.body))
        xml.feature_image_url post.feature_image_url(:list)
      end
    end

  end

end