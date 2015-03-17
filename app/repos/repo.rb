module Repo
  module Record
    def as_json
      id = getId
      links = out_edges.map{ |e| {e.label.to_sym => e.in_vertex.getId} }.inject(&:merge)

      properties.symbolize_keys.merge id: id, links: links
    end
  end
end


