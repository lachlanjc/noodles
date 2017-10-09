import React from 'react'
import PropTypes from 'prop-types'
import Icon from './Icon'

const RecipeListComplication = ({ tooltip, icon, ...props }) => (
  <a
    className="mlm lh0 tooltipped"
    aria-label={tooltip}
    children={<Icon icon={icon} className="fill-grey-3" />}
    {...props}
  />
)

RecipeListComplication.propTypes = {
  tooltip: PropTypes.string.isRequired,
  icon: PropTypes.string.isRequired
}

export default RecipeListComplication
