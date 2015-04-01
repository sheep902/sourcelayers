Component = require 'framework/component'

Titlebar = require 'components/titlebar'
Tree = require 'components/tree'
SearchButton = require 'components/search_button'

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
      <div className='histories'>
        <div className='history'>
           history
        </div>
        <div className='history'>
           history
        </div>
      </div>
    </div>