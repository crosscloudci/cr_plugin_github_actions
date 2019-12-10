require "./concerns/*"
require "halite"
require "debug"

class CrPluginGithubActions::CLI::Commands::GithubActions < Admiral::Command
  include CIAuth
  define_help description: "Github Action for retieving status for your project commits"

  define_flag project : String,
    description: "The name of the project in the repository, e.g. test_proj",
    long: project,
    short: p,
    required: true

  define_flag ref : String,
    description: "The commit ref of the project build that is of interest, e.g. 834f6f1 or a1724ce5e0c59bef272723f328e675980ddc90ea",
    long: ref,
    short: r,
    required: true

  @returned_build_status = String.new
  @returned_build_url = String.new
  def run 
    client = init_github_http_client
    r = client.get("/repos/#{flags.project}/commits/#{URI.encode_www_form(flags.ref)}/status")
    #for checkruns API
    # r = client.get("/repo/#{URI.encode_www_form(flags.owner)}/#{URI.encode_www_form(flags.project)}/commits/#{URI.encode_www_form(flags.ref)}/check-runs")
    begin
      r.raise_for_status
      response_body = JSON.parse(r.body)
      @returned_build_status = response_body["state"].as_s
      @returned_build_url = response_body["statuses"].as_a.last["target_url"].as_s
    end 	
    puts "status\t build_url\n"
    puts "#{@returned_build_status} #{@returned_build_url}"
  end 
end
