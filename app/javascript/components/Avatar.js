import React from 'react'
import PropTypes from 'prop-types'

const Avatar = ({ src, size = 48, style, ...props }) => (
  <img
    {...props}
    src={src}
    style={{
      width: size,
      height: size,
      borderRadius: size / 2,
      display: 'inline-block',
      flexShrink: 0,
      ...style
    }}
  />
)

Avatar.propTypes = {
  src: PropTypes.string.isRequired,
  size: PropTypes.number,
  style: PropTypes.object
}

export default Avatar
