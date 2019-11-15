Gem::Specification.new do |spec|
  spec.name          = 'noon'
  spec.version       = '0.9.2'
  spec.authors       = ["Rafat Katta"]
  spec.email         = ["rafatkatta@gsibc.net"]
  spec.date          = '2019-10-14'
  spec.summary       = %q{Noon cryptocurrency.}
  spec.description   = %q{Noon cryptocurrency base unit.}
  spec.homepage      = "https://github.com/rafatkatta/noon"
  spec.license       = "MIT"
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files | grep rb | grep lib`.split("\n")
  end
end
