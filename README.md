# cr_plugin_github_actions

## Usage

**Required Arguments**

-p or --project is the project name in the format of orgname/project
-c or --commit is the commit reference
-t or --tag is the tag name

## Status executable and response format

1. The output is tab delimited
2. The first line is a header
3. The second line is data
4. The status should be success, failure, or running
5. The build_url should be the url where the status was found


```
./ci_plugin_travis_go status -p "linkerd/linkerd2" -c f27d7b65
status  build_url
success https://travis-ci.org/crosscloudci/testproj/builds/572521581
```

## Contributing

1. Fork it (<https://github.com/your-github-user/cr_plugin_github_actions/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [W. Watson](https://github.com/wavell) - creator and maintainer
- [Joshua Darius](https://github.com/nupejosh) - creator and maintainer
