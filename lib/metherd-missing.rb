require "metherd-missing/version"
require "metherd-missing/levenshtein_distance"
require "metherd-missing/trie_node"

module Kernel
  def method_missing(method, *args, &block)
    possible_method_names = self.methods.map(&:to_s)
    results = MetherdMissing::LevenshteinDistance.new(possible_method_names).search(method, 1)
    if results.any?
      correct_typos!(method.to_s, results.keys.first.to_s, caller[0])
      self.send(results.keys.first.to_s, *args, &block)
    else
      super
    end
  end

  def correct_typos!(old, new, location)
    filename, lno, method = location.split(":")
    lno = lno.to_i - 1
    if File.exist?(filename)
      file = File.readlines(filename)
      line = file[lno]
      if line && line.include?(old)
        puts "You called `#{self.class}##{old}` when you meant `#{self.class}##{new}`"
        puts "Would you like me to fix this for you?"
        puts "\e[0;33m#{File.expand_path(filename)}:#{lno}\e[0m"
        puts "  #{file[lno - 1]}"
        puts "\e[0;31m- #{line.rstrip}\e[0m"
        puts "\e[0;32m+ #{line.gsub(old, new).rstrip}\e[0m"
        puts "  #{file[lno + 1]}"
        print "Make change? Y/n> "

        if STDIN.gets =~ /y/i
          File.open(filename, 'w') do |f|
            f.puts file[0..lno].join
            f.puts line.gsub(old, new)
            f.puts file[(lno + 1)..-1].join
          end
        end
      end
    end
  end

end
