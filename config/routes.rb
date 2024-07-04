Rails.application.routes.draw do
  get 'repos/:owner/:repo/commits/:commit_sha', to: 'repos#show_commit'
  get 'repos/:owner/:repo/commits/:commit_sha/diff', to: 'repos#show_commit_diff'
end
