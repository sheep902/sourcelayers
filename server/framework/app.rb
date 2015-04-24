module App
  def self.all(type)
    type = type.to_s.pluralize
    base_path = "server/#{type}"

    attributes[type] ||= Pathname.glob("#{base_path}/*.rb").map{ |name| name.basename '.*' }.map(&:to_s)
      .map{|name| {name => name.classify.constantize}}.join(&:merge).symbolize_keys
  end

  def self.sketch_of(name)
    name = name.to_s.singularize.pluralize
    file_path = "sketch/#{name}.yml"

    YAML.load_file(file_path).deep_symbolize_keys
  end
end