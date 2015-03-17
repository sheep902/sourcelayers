React = require 'react'

module.exports = React.createClass
  render: ->
    <div className='header'>
      <h2>Cloning Repository</h2>
      {
        switch @props.status
          when undefined
            <p className='mui-font-style-subhead-1'>We need a public accessible git repository to clone from.</p>
          when 'created'
            <p className='mui-font-style-subhead-1'>downloading ...</p>
          when 'conflict'
            <p className='mui-font-style-subhead-1'><span className='accent'>Conflict</span></p>
      }
    </div>
