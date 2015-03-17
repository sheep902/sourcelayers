React = require 'react'
Intention = require 'lib/intention.coffee'
Router = require 'lib/router.coffee'
Whiteboard = require 'lib/whiteboard.coffee'

Search = require './index/search.cjsx'
Results = require './index/results.cjsx'
Footer = require 'views/main/footer.cjsx'


ID = require 'views/mixins/id.coffee'

module.exports = React.createClass
  displayName: 'project.index'

  mixins: [Whiteboard.watch('searching'), Intention, ID]

  getInitialIntentions: ->
    projects:
      query: 'projects'

  componentDidMount: ->
    $('.main').scrollTop Whiteboard.read(@id() + 'scroll')

  componentDidUpdate: ->
    if Whiteboard.read 'searching'
      search_node = @refs.search.getDOMNode()
      $('.main').scrollTo(search_node, duration: 90)
      Whiteboard.clear 'searching'

  triggerSearch: (text)->
    @setIntention 'projects', query: 'projects', remote: text

  render: ->
    <div className='index'>
      <Search ref='search' search={(value)=> @triggerSearch value}
       status={@intentions.projects?.value().status}/>
      <Results projects={@intentions.projects?.payload()} status={@intentions.projects?.status()}/>
      <Footer/>
    </div>

  componentWillUnmount: ->
    Whiteboard.write @id() + 'scroll', $('.main').scrollTop()

