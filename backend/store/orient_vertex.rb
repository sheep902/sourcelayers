import com.tinkerpop.blueprints.impls.orient.OrientVertex

class OrientVertex
  def []=(key, value)
    set_property key.to_s, value
  end

  def [](key)
    get_property key.to_s
  end

  def id
    get_identity.to_s.delete '#'
  end

  def as_json(ignored=nil)
    get_property_keys.map{|key| {key => self[key]}}.push(id: id)
      .inject(&:merge).symbolize_keys
  end
end