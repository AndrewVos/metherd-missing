module MetherdMissing
  class TrieNode
    attr_accessor :word, :children

    def initialize
      @children = {}
    end

    def insert word
      node = self
      word.each_char do |letter|
        unless node.children[letter]
          node.children[letter] = TrieNode.new
        end
        node = node.children[letter]
      end
      node.word = word
    end
  end
end
