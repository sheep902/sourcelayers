# Don't open new tx in this layer
module PacerRecord
  extend ActiveSupport::Concern

  included do
    self.const_set :Vertex, self
    self.const_set :Route, self

    def id
      getId.to_s.sub(':', '_').sub('#', '')
    end

    def connect(params)
      to = params[:to]
      through = params[:through] || :relation
      $pacer.create_edge nil, self, to, through
    end

    def links; {} end
    def props; {} end

    def to_h
      id_prop = {id: id}
      links_as_prop = {links: links}
      id_prop.merge(props).merge(links_as_prop)
    end
  end

  class_methods do
    def search(conditions={})
      $pacer.v(self, conditions.merge(route_conditions))
    end

    alias_method :all, :search

    def [](id)
      id = id.sub '_', ':'
      $pacer.vertex(id, self)
    end

    def route_conditions(ignored=nil)
      {type: model_name}
    end

    def model_name
      name.underscore
    end

    def links(*names)
      define_method :links do
        super_links = (defined? super) ? super : {}
        names.map{ |name|
          return {} unless respond_to? name
          {name => send(name).to_a.map(&:id)}
        }.inject(&:merge).merge(super_links)
      end
    end

    def props(*names)
      define_method :props do
        super_props = (defined? super) ? super : {}
        names.map{ |name|
          {name => properties[name.to_s]}
        }.inject(&:merge).merge(super_props)
      end
    end

    def create(props={})
      $pacer.create_vertex(self, props.merge(route_conditions))
    end
  end

end