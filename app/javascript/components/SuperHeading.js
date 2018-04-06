import React from 'react'
import PropTypes from 'prop-types'

const SuperHeading = ({ className, style, ...props }) => {
  const sx = {
    fontWeight: '800',
    lineHeight: 1,
    marginTop: 0,
    paddingBottom: N.space[2],
    ...style
  }
  const cx = 'superheading sans f1 f0-ns mbn mbl-ns border-bottom'
  return <h1 {...props} style={sx} className={N.cxs([cx, className])} />
}

SuperHeading.propTypes = {
  className: PropTypes.string,
  style: PropTypes.object
}

export default SuperHeading
