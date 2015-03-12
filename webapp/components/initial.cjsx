React = require 'react'

module.exports = React.createClass
  render: ->
    colors = ["#1abc9c", "#16a085", "#f1c40f", "#f39c12", "#2ecc71", "#27ae60",
      "#e67e22", "#d35400", "#3498db", "#2980b9", "#e74c3c", "#c0392b", "#9b59b6",
      "#8e44ad", "#bdc3c7", "#34495e", "#2c3e50", "#95a5a6", "#7f8c8d", "#ec87bf",
      "#d870ad", "#f69785", "#9ba37e", "#b49255", "#b49255", "#a94136"]

    size = @props.size
    font_size = size * 0.6
    text = if @props.name
             @props.name.substr(0, 2).toUpperCase();
           else
             ''
    color_index = Math.floor(text.charCodeAt(0) % colors.length);

    <svg xmlns='http://www.w3.org/2000/svg' pointer-events='none'
      width={size} height={size} style={
        backgroundColor: colors[color_index]
        width: size + 'px'
        height: size + 'px'
      }>
      <text textAnchor='middle' x='50%' y='50%' dy='0.35em' pointer-events='auto'
            fill='#fff' style={
               font_family: 'Roboto'
               font_size: font_size + 'px'
            }>
        {text}
      </text>
    </svg>

