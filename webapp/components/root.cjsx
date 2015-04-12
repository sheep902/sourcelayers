Component = require 'framework/component'

Titlebar = require 'components/titlebar'
Tree = require 'components/tree'
SearchButton = require 'components/search_button'
Histories = require 'components/histories'

Entry = require 'components/user/entry'

module.exports = Component
  cursors:
    main: ['current', 'main']
    user: ['current', 'user']

  render: ->
    <div className='root'>
      <div className='navigation'>
        <Titlebar/>
        <Tree/>
      </div>
      {
        if @state.cursors.user
          switch @state.cursors.main
            when 'project' then undefined
            when 'file' then undefined
            when 'document' then undefined
            when 'user' then undefined
        else
          <Entry className='main'/>
      }
      <SearchButton className='main-button'/>
      <Histories/>
    </div>