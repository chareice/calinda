set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

set :markdown_engine, :redcarpet
set :markdown, :tables => true, :autolink => true, :strikethrough => true, :superscript => true, :footnotes => true

configure :build do
  activate :minify_css
  activate :minify_javascript
end

activate :blog do |blog|
  blog.prefix = "articles"
  blog.layout = "article"
end

activate :minify_html
activate :gzip
site_config = {
  :title => "Chareice",
  :description => "Write The Code,Change The World",
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
  :signoff => "Chareice"
}

set :site_config, site_config
