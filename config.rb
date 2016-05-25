set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :tables => true, :autolink => true, :strikethrough => true, :superscript => true, :footnotes => true

activate :asciidoc, :asciidoc_attributes => %w()

configure :build do
  activate :minify_css
  activate :minify_javascript
end

activate :blog do |blog|
  blog.prefix = "articles"
  blog.layout = "article"
  blog.taglink = "/tags/{tag}.html"
  blog.tag_template = 'tags.html'
end

activate :minify_html
activate :gzip
site_config = {
  :title => "Chareice",
  :description => "Hi, I'm Chareice, A Web Developer.",
  :links => [
    {
      :name => "Twitter",
      :url => "//twitter.com/ShaoChenglei"
    },
    {
      :name => "Github",
      :url => "//github.com/chareice"
    }
  ],
  :disqus_shortname => "chareice-blog",
  :signoff => "Chareice",
  :date_format => "%d %b %Y",
  :cdn_address => "//dn-chareicecnd.qbox.me"
}

set :site_config, site_config
