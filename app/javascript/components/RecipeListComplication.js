import React from 'react'
import PropTypes from 'prop-types'
import Icon from './Icon'

const RecipeListComplication = ({ tooltip, glyph, ...props }) => (
  <a
    className="mlm lh0 grey-3 tooltipped"
    aria-label={tooltip}
    children={<Icon glyph={glyph} />}
    {...props}
  />
)

RecipeListComplication.propTypes = {
  tooltip: PropTypes.string.isRequired,
  glyph: PropTypes.string.isRequired
}

export default RecipeListComplication
