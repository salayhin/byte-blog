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
        xml.pubDate(post.created_at.rfc2822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end

  end

end