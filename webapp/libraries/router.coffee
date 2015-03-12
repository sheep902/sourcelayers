# will be replaced when architecture is stable
class Route
  init: (root)->
    @root_url = root
    window.addEventListener 'popstate', (=> @app.forceUpdate())

  conflict: (conflict_sets)->
    @conflict_sets = conflict_sets

  resources: (resource_names)->
    @resource_names = resource_names

  root_component: (component)->
    @app = component

  state: ->
    path = @_url_parts()

    keys = []
    path.forEach (key, index) ->
      return if index % 2
      keys.push key

    values = []
    path.forEach (value, index) ->
      return unless index % 2
      values.push value

    keys.zip(values).map (pair)-> item = {}; item[pair[0]] = pair[1]; item
      .reduce ((result, item)-> result.merge item), {}

  root: ->
    path = @_url_parts()
    path[0] unless path.isEmpty()

  goto: (obj)->
    current = @state()

    next = current
    obj.each (key, value)=>
      conflict_sets = @conflict_sets.filter (set) -> key in set
      conflict_sets.each (set)->
        set.each (item)->
          delete next[item]

      next[key] = value

    uri = '/'
    @resource_names.each (name)->
      if next[name]?
        uri = uri + name + '/' + next[name].toString()

    window.history.pushState {}, '', @root_url + uri

    @app.forceUpdate()

  query_params: (obj)->

  search: (obj)->

  _url_parts: ->
    window.location.pathname.split('/').filter (part)-> part isnt ''

window.router = module.exports = new Route()
