import React from 'react'
import PropTypes from 'prop-types'

const SectionHeader = ({ level = 1, className, children, ...props }) => {
  const Tag = `h${level}`
  const cx = ['section-header', className].join(' ')
  return (
    <Tag className={cx} {...props}>
      <span className="section-header__name" children={children} />
    </Tag>
  )
}

SectionHeader.propTypes = {
  level: PropTypes.oneOf([1, 2, 3, 4]),
  className: PropTypes.string,
  children: PropTypes.element
}

export default SectionHeader
