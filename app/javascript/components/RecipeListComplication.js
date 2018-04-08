import React from 'react'
import PropTypes from 'prop-types'
import Icon from './Icon'

const RecipeListComplication = ({
  is = 'a',
  tooltip,
  glyph,
  color = 'grey-3',
  actionRef,
  ...props
}) => {
  const Component = is
  return (
    <Component
      className={N.cxs(['dib mlm lh0 tooltipped', color])}
      aria-label={tooltip}
      children={<Icon glyph={glyph} />}
      {...props}
      ref={actionRef}
    />
  )
}

RecipeListComplication.propTypes = {
  is: PropTypes.oneOfType([PropTypes.string, PropTypes.element]),
  tooltip: PropTypes.string.isRequired,
  glyph: PropTypes.string.isRequired,
  color: PropTypes.string
}

export default RecipeListComplication
