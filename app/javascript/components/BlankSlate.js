import React from 'react'
import PropTypes from 'prop-types'

const BlankSlate = ({ margin, className, ...props }) => (
  <article
    {...props}
    className={N.cxs([
      'measure border rounded pal tc mx-auto',
      margin || 'mvl',
      className
    ])}
    style={{
      borderWidth: 2,
      borderStyle: 'dashed'
    }}
  />
)

BlankSlate.propTypes = {
  className: PropTypes.string,
  margin: PropTypes.string
}

export default BlankSlate
