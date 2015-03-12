React = require 'react'

MUI = require 'material-ui'
TextField = MUI.TextField
Spinner = require 'components/spinner.cjsx'

module.exports = React.createClass
  render: ->
    <div className='main-block search'>
      <TextField hintText='Search Projects'
       onChange={(e)=> @props.search e.target.value}/>
       {
         if @props.status is 'pending'
           <Spinner/>
       }
    </div>
