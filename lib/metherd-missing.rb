require "metherd-missing/version"
require "metherd-missing/levenshtein_distance"
require "metherd-missing/trie_node"

module Kernel
  def method_missing(method, *args, &block)
    possible_method_names = self.methods.map(&:to_s)
    results = MetherdMissing::LevenshteinDistance.new(possible_method_names).search(method, 1)
    if results.any?
      found_method = results.keys.first.to_s
      warn "[MetherdMissing] #{method} called from #{caller.first} not found, using similarly named #{found_method} method"
      self.send(found_method, *args, &block)
    else
      super
    end
  end
end
