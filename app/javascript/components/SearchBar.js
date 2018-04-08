import React from 'react'
import PropTypes from 'prop-types'

import Icon from './Icon'

const SearchBar = ({ count, className, children, ...props }) => (
  <section
    role="search"
    className={N.cxs(['flex fac mvs phm dn-p', className])}
  >
    <Icon glyph="search" className="grey-3 fsn" />
    <input
      type="text"
      placeholder={
        `Search ${count !== 1 ? 'these' : 'for the'}` +
        ` ${count} ${count !== 1 ? 'recipes' : 'recipe'}…`
      }
      style={{
        height: 36
      }}
      {...props}
      className="text-input invisible-input flex-auto"
    />
    {children}
  </section>
)

SearchBar.propTypes = {
  className: PropTypes.string,
  count: PropTypes.number.isRequired
}

export default SearchBar
