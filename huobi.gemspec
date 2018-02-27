
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "huobi/version"

Gem::Specification.new do |spec|
  spec.name          = "huobi"
  spec.version       = Huobi::VERSION
  spec.authors       = ["Sebastian"]
  spec.email         = ["sebastian.johnsson@gmail.com"]

  spec.summary       = %q{Huobi: REST and Websocket client in Ruby for Huobi.pro}
  spec.description   = %q{Huobi: REST and Websocket client in Ruby for the crypto currency exchange Huobi.pro}
  spec.homepage      = "https://github.com/SebastianJ/huobi"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday",                ">= 0.13"
  spec.add_dependency "faraday_middleware",     ">= 0.12.2"
  spec.add_dependency "addressable",            ">= 2.5.2"
  
  spec.add_development_dependency "bundler",    "~> 1.16"
  spec.add_development_dependency "rake",       "~> 10.0"
  spec.add_development_dependency "rspec",      "~> 3.0"
  spec.add_development_dependency "rdoc",       "~> 6.0"
  spec.add_development_dependency "vcr",        "~> 4.0"
  spec.add_development_dependency "webmock",    "~> 3.1"
end
