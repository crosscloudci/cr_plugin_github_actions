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

  define_flag commit : String,
    description: "The commit ref of the project build that is of interest, e.g. 834f6f1 or a1724ce5e0c59bef272723f328e675980ddc90ea",
    long: commit,
    short: c,
    required: true

  @returned_build_status = String.new
  @returned_build_url = String.new
  def run 
    client = init_github_http_client
    r = client.get("/repos/#{flags.project}/commits/#{URI.encode_www_form(flags.commit)}/status")
    #for checkruns API
    begin
      response_body = JSON.parse(r.body)
      if response_body["state"]? == nil
        puts "ERROR: failed to find project with given commit. #{response_body["message"]}"
        exit 1
      end
      @returned_build_status = response_body["state"].as_s
      @returned_build_url = response_body["statuses"].as_a.last["target_url"].as_s
      case @returned_build_status
      when "scheduled"
        @returned_build_status = "running"
      when "running"
        @returned_build_status = "running"
      when "retried"
        @returned_build_status = "running"
      when "started"
        @returned_build_status = "running"
      when "passed"
        @returned_build_status = "success"
      when "canceled"
        @returned_build_status = "failed"
      when "infrastructure_fail"
        @returned_build_status = "failed"
      when "timedout"
        @returned_build_status = "failed"
      when "failure"
        @returned_build_status = "failed"
      end
    end 	
    puts "status\t build_url\n"
    puts "#{@returned_build_status}\t #{@returned_build_url}"
  end 
end
