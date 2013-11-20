# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "matrices/version"

Gem::Specification.new do |s|
  s.name = "matriz"
  s.version = Matriz::VERSION
  s.authors = ["Mª Belen Armas Torres | Aaron Socas Gaspar"]
  s.email = ["alu0100696677@ull.edu.es | alu0100207385@ull.edu.es"]
  s.homepage = "https://github.com/alu0100207385/pract10.git"
  s.summary = %q{Creación de matrices}
  s.description = %q{Permite representar y realizar operaciones con matrices densas y dispersas}

  s.rubyforge_project = "matrices"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
end
