class ReposController < ApplicationController
	before_action :set_github_client

  def show_commit
    owner = params[:owner]
    repo = params[:repo]
    commit_sha = params[:commit_sha]

    commit = @client.commit("#{owner}/#{repo}", commit_sha)
    render json: commit, status: 200
  end

  def show_commit_diff
    owner = params[:owner]
    repo = params[:repo]
    commit_sha = params[:commit_sha]

    commit = @client.commit("#{owner}/#{repo}", commit_sha)
    parent_commit_sha = commit[:parents][0][:sha] rescue nil
    if parent_commit_sha.present?
    	comparison = @client.compare("#{owner}/#{repo}", parent_commit_sha, commit_sha)
    	render json: comparison[:files],  status: 200
    else
    	render json: {message: "Parents is nil"},  status: 404
    end
  end

  private

  def set_github_client
    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
  end
end
