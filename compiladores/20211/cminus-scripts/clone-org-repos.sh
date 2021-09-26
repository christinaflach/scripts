curl -s https://api.github.com/orgs/mata61-ufba-20211/repos?per_page=200 | ruby -r rubygems -e 'require "json"; JSON.load(STDIN.read).each { |repo| %x[git clone #{repo["ssh_url"]} ]}'


