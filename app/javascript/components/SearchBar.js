import React, { useRef, useEffect } from 'react'
import PropTypes from 'prop-types'

import Icon from './Icon'

const useFocusable = (input, label) => {
  const focusInput = e => {
    if (e.key === '/' && input) input.current.focus()
  }
  useEffect(() => {
    document.addEventListener('keyup', focusInput)
    return () => {
      document.removeEventListener('keyup', focusInput)
    }
  }, [])

  return label
}

const SearchBar = ({ count, className, children, ...props }) => {
  const input = useRef(null)
  useFocusable(input)
  return (
    <section
      role="search"
      className={N.cxs(['flex fac mvs phm dn-p', className])}
    >
      <Icon glyph="search" className="grey-3 fsn" />
      <div className="flex-auto relative">
        <input
          type="text"
          inputMode="search"
          placeholder={
            `Search ${count !== 1 ? 'these' : 'for the'}` +
            ` ${count} ${count !== 1 ? 'recipes' : 'recipe'}…`
          }
          style={{
            height: 36
          }}
          ref={input}
          {...props}
          className="text-input invisible-input text-input--slash w-100"
        />
        <kbd
          className="dib absolute bg-grey-5 f5 tc border br--sm tooltipped"
          aria-label="Press / to start searching"
          style={{
            width: '1.5rem',
            height: '1.5rem',
            lineHeight: '1.5rem',
            right: 0,
            top: 5
          }}
        >
          /
        </kbd>
      </div>
      {children}
    </section>
  )
}

SearchBar.propTypes = {
  className: PropTypes.string,
  count: PropTypes.number.isRequired
}

export default SearchBar
