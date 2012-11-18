module MetherdMissing
  class LevenshteinDistance
    def initialize(words)
      @trie = TrieNode.new
      words.each do |word|
        @trie.insert(word)
      end
    end

    def search word, maximum_distance
      current_row = (0..word.length).to_a
      results = {}
      @trie.children.keys.each do |letter|
        search_recursive(
          @trie.children[letter],
          letter,
          word,
          current_row,
          results,
          maximum_distance
        )
      end
      results
    end

    private

    def search_recursive node, letter, word, previous_row, results, maximum_distance
      columns = word.length + 1
      current_row = [previous_row.first + 1]

      (1...columns).each do |column|
        insert_cost = current_row[column - 1] + 1
        delete_cost = previous_row[column] + 1

        if word[column - 1] != letter[0]
          replace_cost = previous_row[column - 1] + 1
        else
          replace_cost = previous_row[column - 1]
        end

        current_row << [insert_cost, delete_cost, replace_cost].min
      end

      if current_row.last <= maximum_distance && node.word
        results[node.word] = current_row.last
      end

      if current_row.min <= maximum_distance
        node.children.keys.each do |letter|
          search_recursive(node.children[letter], letter, word, current_row, results, maximum_distance)
        end
      end
    end
  end
end
