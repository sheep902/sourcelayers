Component = require 'framework/component'

Titlebar = require 'components/titlebar'
Tree = require 'components/tree'
SearchButton = require 'components/search_button'
Histories = require 'components/histories'

SignUp = require 'components/user/sign_up'

module.exports = Component
  cursors:
    main: 'main'

  render: ->
    <div className='root'>
      <div className='navigation'>
        <Titlebar/>
        <Tree/>
      </div>
      <SignUp className='main'/>
      <SearchButton className='main-button'/>
      <Histories/>
    </div>