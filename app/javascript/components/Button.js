import React from 'react'
import PropTypes from 'prop-types'

const Button = ({
  is,
  href,
  serif,
  color = 'blue',
  primary,
  sm,
  className,
  ...props
}) => {
  const Tag = is || (_.isEmpty(href) ? 'button' : 'a')
  const cx = [
    'btn',
    sm && 'btn-sm',
    primary && 'btn--primary',
    color && `bg-${color}`,
    serif && 'serif',
    className
  ]
  return <Tag {...props} href={href} className={N.cxs(cx)} />
}

Button.propTypes = {
  is: PropTypes.string,
  href: PropTypes.string,
  serif: PropTypes.bool,
  color: PropTypes.oneOf([
    'orange',
    'blue',
    'green',
    'pink',
    'red',
    'grey-3',
    'grey-2'
  ]),
  primary: PropTypes.bool,
  sm: PropTypes.bool,
  className: PropTypes.string
}

export default Button
