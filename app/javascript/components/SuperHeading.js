import React from 'react'
import PropTypes from 'prop-types'

const SuperHeading = ({ className = 'orange', style, ...props }) => {
  const sx = {
    fontWeight: '800',
    lineHeight: 1,
    marginTop: 0,
    paddingBottom: N.space[2],
    ...style
  }
  const cx = ['superheader sans f1 f0-ns mbn mbl-ns border-bottom', className]
  return <h1 {...props} style={sx} className={N.cxs(cx)} />
}

SuperHeading.propTypes = {
  className: PropTypes.string,
  style: PropTypes.object
}

export default SuperHeading
