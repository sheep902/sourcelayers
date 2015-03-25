View = require 'framework/view'

SvgIcon = require('material-ui').SvgIcon
MainButton = require('material-ui').FloatingActionButton

Navigation = require('./root/navigation')

module.exports = View
  render: ->
    <div className='root'>
      <Navigation className='navigation'/>
      <div className='main'/>
      <MainButton onClick={=> @start 'sign_up', 'bob', 'alice'} className='main-button'>
        <SvgIcon style={top: '2px'}>
          <path d='M11 20v-6h4v6h5v-8h3L12 3 2 12h3v8z' style={fill:'white'}></path>
        </SvgIcon>
      </MainButton>
      <div className='histories'/>
    </div>