curl -s https://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:@api.github.com/orgs/mata61-ic-ufba/repos\?per_page\=200 | jq ".[].ssh_url" | xargs -n 1 git clone --recursive 


