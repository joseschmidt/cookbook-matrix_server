README
======

This document describes how to add/update foodcritic rules.

Add Rules (via `git`)
---------------------

```
git submodule add git://github.com/customink-webops/foodcritic-rules.git spec/foodcritic/customink
git submodule add git://github.com/etsy/foodcritic-rules.git spec/foodcritic/etsy
```

Unable to get this one to work:

```
git submodule add git://github.com/lookout/lookout-foodcritic-rules.git spec/foodcritic/lookout
```

Output:

```
rake aborted!
undefined method `apt_repository' for #<FoodCritic::RuleDsl:0x007fa003e2aa40>
spec/foodcritic/lookout/sample_cookbooks/lkout002/recipes/invalid_apt_resource.rb:1:in `block in load'
/Users/doc/.rvm/gems/ruby-1.9.3-p484@global/bin/ruby_executable_hooks:15:in `eval'
/Users/doc/.rvm/gems/ruby-1.9.3-p484@global/bin/ruby_executable_hooks:15:in `<main>'
Tasks: TOP => foodcritic
(See full trace by running task with --trace)
```


Update Rules (via `git`)
------------------------

Note: Travis-CI is setup to automatically run this prior to builds (via `travis.yml`).

```
git submodule update --init --recursive
```


References
----------

- [Testing Chef Cookbooks](http://technology.customink.com/blog/2012/08/03/testing-chef-cookbooks/)
- [Chef Cookbook Code Quality with Foodcritic](http://www.neverstopbuilding.com/foodcritic)
- [CustomInk Foodcritic Rules](https://github.com/customink-webops/foodcritic-rules)
- [Etsy Foodcritic Rules](https://github.com/etsy/foodcritic-rules)
- [Remove a Submodule within git](http://davidwalsh.name/git-remove-submodule)
