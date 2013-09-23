mandrel Cookbook
=================

This cookbook provides a LWRP for projects that use the python-mandrel pip,
which can be found here: https://github.com/ethanrowe/python-mandrel

The purpose of this Chef LWRP is to make the laying out of Mandrel.py files easier
durning deploys for projects that use python-mandrel.


Requirements
------------

#### pip
- `mandrel` - this Chef LWRP is pointless without your project using this pip.

Usage
-----
#### mandrel::default

e.g.
Calling the mandrel resource using some defaults and expected common overrides;

```ruby
mandrel "/some/project/release/current" do
  owner                    'unique_owner'
  group                    'unique_group'
end
```

#### mandrel::pylog

e.g.
Calling the mandrel resource using some defaults and expected common overrides;

```ruby
mandrel_pylog "/some/project/release/current" do
  owner                    'unique_owner'
  group                    'unique_group'
end
```

Contributing
------------

1. Fork the repository on Github
2. File an issue with the canonical repository
3. Create a named feature branch referencing that issue
4. Write your change
5. Write tests for your change (if possible within existing test infra)
6. Run the tests, ensuring they all pass
7. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Will Drew
License: MIT
