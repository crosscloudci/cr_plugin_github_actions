require "halite"
require "poncho"
module CrPluginGithubActions::CLI::Commands::CIAuth
	def init_github_http_client
		client = Halite::Client.new do
			# Set basic auth
			# basic_auth "#{ci_auth["key"]}", ""
			# Enable logging
			# logging true
			logging false
			timeout 10.seconds
      headers "Accept": "application/vnd.github.antiope-preview+json"
			headers "Accept": "application/json"
			headers "username": "crosscloudci"
      endpoint "https://api.github.com/"
		end
	end
end 
