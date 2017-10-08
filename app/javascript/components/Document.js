import React from 'react'
import PropTypes from 'prop-types'

const Document = ({ className, measure, mw, ...props }) => (
  <main
    {...props}
    className={N.cxs([
      'document',
      measure && 'measure',
      mw && `mw${mw || 7}`,
      className
    ])}
  />
)

Document.propTypes = {
  className: PropTypes.string,
  measure: PropTypes.bool,
  mw: PropTypes.oneOf([5, 6, 7, 8])
}

export default Document
