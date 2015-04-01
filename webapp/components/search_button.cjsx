Component = require 'framework/component'

MainButton = require('material-ui').FloatingActionButton
SvgIcon = require('material-ui').SvgIcon

module.exports = Component
  cursors:
    search_enabled: 'search_enabled'

  render: ->
    <MainButton onClick={=> @intent 'start_search'} className={@props.className}
      disabled={not @state.cursors.search_enabled}>
      <SvgIcon style={top: '2px'}>
        <path d="M15.5 14h-.79l-.28-.27c.98-1.14 1.57-2.62 1.57-4.23 0-3.59-2.91-6.5-6.5-6.5s-6.5 2.91-6.5 6.5 2.91 6.5 6.5 6.5c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99 1.49-1.49-4.99-5zm-6 0c-2.49 0-4.5-2.01-4.5-4.5s2.01-4.5 4.5-4.5 4.5 2.01 4.5 4.5-2.01 4.5-4.5 4.5z" style={fill: 'white'}/>
      </SvgIcon>
    </MainButton>

