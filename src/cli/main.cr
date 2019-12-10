# TODO: Write documentation for `CrPluginGithubActions`
require "admiral"
require "halite"
require "./commands/*"

# TODO: Put your code here
class CrPluginGithubActions::CLI::Main < Admiral::Command
  define_version "1.0.0"
  define_help description: "A CI tools that checks project statuses on Github using Github Actions"

  register_sub_command "status", Commands::GithubActions

end

def CrPluginGithubActions::CLI.run(*args, **named_args)
  CrPluginGithubActions::CLI::Main.run(*args, **named_args)
end
