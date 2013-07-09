# encoding: utf-8

Gem::Specification.new do |s|
  s.name        = 'mongolita'
  s.version     = '0.1.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ivan Povalyukhin']
  s.email       = ['ipoval@ya.ru']
  s.homepage    = 'https://github.com/ipoval/mongolita'
  s.summary     = %q{MONGODB EXTENDED SHELL ANALYTICS TOOLS AND FUNCTIONS}
  s.description = %q{MONGODB EXTENDED SHELL ANALYTICS TOOLS AND FUNCTIONS}

  s.rubyforge_project = 'mongolita'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0.0'
  s.required_rubygems_version = '>= 1.3.5'

  s.extra_rdoc_files = ['README']
  s.license = 'MIT'

  { rspec:     '~> 2.14.0',
    bundler:   '~> 1.3.4', }.each { |lib, v| s.add_development_dependency lib.to_s, v }
end
