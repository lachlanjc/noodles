import React from 'react'
import PropTypes from 'prop-types'
import Icon from './Icon'

const RecipeListComplication = ({
  is = 'a',
  tooltip,
  glyph,
  color = 'grey-3',
  className,
  children,
  ...props
}) => {
  const Component = is
  return (
    <Component
      {...props}
      className={N.cxs(['dib mlm lh0 pointer tooltipped', color, className])}
      aria-label={tooltip}
    >
      <Icon glyph={glyph} />
      {children}
    </Component>
  )
}

RecipeListComplication.propTypes = {
  is: PropTypes.oneOfType([PropTypes.string, PropTypes.element]),
  tooltip: PropTypes.string.isRequired,
  glyph: PropTypes.string.isRequired,
  color: PropTypes.string
}

export default RecipeListComplication
