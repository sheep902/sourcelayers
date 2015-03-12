module Symbol # TODO hope jruby have refinements
  def revert
    if self == :refs
      :defs
    elsif self == :defs
      :refs
    end
  end
end

module Path
  include PacerRecord
  links :document, :parent, :children

  def document
    in_e(:has_document).out_v(Document)
  end

  def name
    self[:name]
  end

  def resolve(results=SizedQueue.new(5), search_stack=nil)
    if results.size == results.max
      return results
    end

    if search_stack.nil?
      in_e(:refs, :defs).map{ |e|
        type = e.label.to_sym
        next_iter = e.out_v(Path)
        search_stack = SearchStack.push name, type
        next_iter.resolve results, search_stack
      }
    elsif search_stack.empty?
      results << self.to_h
    else
      target = search_stack.top
      out_e(target.revert.type).in_v(Path, name: target.name).resolve(results, search_stack.pop)
      in_e(target.type).in_v(Path).resolve(results, search_stack.push(name, target.type))
    end
  end

  def parent
    in_e(:child, :refs, :defs).out_v(Path)
  end

  def children
    out_e(:child, :refs, :defs).in_v(Path)
  end

  class SearchStack < Hamster::Deque
    SearchItem = Struct.new :name, :type do
      def resolves(name, type)
        self.name == name and
            ( (self.type == :defs and type == :refs) || (self.type == :refs and type == :defs) )
      end

      def revert
        SearchItem.new name, (self.type == :refs ? :defs : :refs)
      end
    end

    def self.push(name, type)
      new.push name, type
    end

    def push(name, type)
      s = SearchItem.new name: name, type: type
      super s
    end

    def pop
      super
    end

    def top
      last
    end

  end

end