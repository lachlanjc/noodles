import React from 'react'
import PropTypes from 'prop-types'

const Spacer = ({ x, y, style, ...props }) => (
  <div
    {...props}
    style={{
      width: x,
      height: y,
      ...style
    }}
  />
)

Spacer.propTypes = {
  x: PropTypes.number,
  y: PropTypes.number,
  style: PropTypes.object
}

export default Spacer
