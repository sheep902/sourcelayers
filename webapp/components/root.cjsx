Component = require 'framework/component'

SvgIcon = require('material-ui').SvgIcon
MainButton = require('material-ui').FloatingActionButton

module.exports = Component
  queries:
    projects: 'all_projects'

  render: ->
    console.log @state

    <div className='root'>
      <div className='navigation'>
        <div className='title'>
          title
        </div>
        <div className='tree'>
          <div className='tree-item'>
            item
          </div>
          <div className='tree-item'>
            item
          </div>
          <div className='tree-item'>
            item
          </div>
        </div>
      </div>
      <div className='main'>
        {JSON.stringify @state}
      </div>
      <MainButton onClick={=> @event 'start_search'} className='main-button'>
        <SvgIcon style={top: '2px'}>
          <path d='M11 20v-6h4v6h5v-8h3L12 3 2 12h3v8z' style={fill:'white'}></path>
        </SvgIcon>
      </MainButton>
      <div className='histories'>
        <div className='history'>
           history
        </div>
        <div className='history'>
           history
        </div>
      </div>
    </div>