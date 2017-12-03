import React from 'react'
import PropTypes from 'prop-types'

const Spacer = ({ x, y, style, ...props }) => {
  const sx = {
    width: x,
    height: y,
    ...style
  }
  return <div {...props} style={sx} />
}

Spacer.propTypes = {
  x: PropTypes.number,
  y: PropTypes.number,
  style: PropTypes.object
}

export default Spacer
