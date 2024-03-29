# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ans-seed/version"

Gem::Specification.new do |s|
  s.name        = "ans-seed"
  s.version     = Ans::Seed::VERSION
  s.authors     = ["sakai shunsuke"]
  s.email       = ["sakai@ans-web.co.jp"]
  s.homepage    = "https://github.com/answer/ans-seed"
  s.summary     = %q{seed に関するユーティリティー}
  s.description = %q{rails の db/seed.rb で使用するユーティリティー}

  s.rubyforge_project = "ans-seed"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
