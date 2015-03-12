stringify = require 'json-stable-stringify'

# A global variable/event store
# It will be replaced by props passing when the architecture is clear to me
class Whiteboard

  # mixin
  @watch: (topic)=>
    topic = stringify topic

    componentDidMount:->
      (Whiteboard.registry[topic] ||= []).push this

    componentWillUnmount:->
      (Whiteboard.registry[topic] ||= []).remove this

  @write: (topic, content)=>
    topic = stringify topic

    @contents[topic] = content
    @update_components(topic)

  @read: (topic)=>
    @contents[stringify topic]

  @clear: (topic)=>
    delete @contents[topic]

  # ^
  # | public methods
  # |
  #--------------------
  # |
  # | private methods
  # v

  @registry: {}

  @contents: {}

  @update_components: (topic)=>
    if @registry[topic]?.isArray()
      @registry[topic].forEach (component)-> component.forceUpdate()

module.exports = Whiteboard