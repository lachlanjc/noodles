import React from 'react'
import PropTypes from 'prop-types'
import Spacer from './Spacer'
import SuperHeading from './SuperHeading'

const SplitLayout = ({
  heading,
  headingClassName,
  sidebar,
  content,
  contentClassName,
  className,
  ...props
}) => (
  <main
    {...props}
    style={{
      boxSizing: 'border-box',
      alignItems: 'flex-start',
      width: '100%'
    }}
    className={N.cxs(['flex-md', className || 'pvm phl-ns'])}
  >
    <aside className="w-50-m w-third-l measure--narrow-ns pam mbm pan-ns man-ns">
      {heading && (
        <SuperHeading
          className={N.cxs(['mbs mbl-ns', headingClassName])}
          children={heading}
        />
      )}
      {sidebar}
    </aside>
    <Spacer x={48} className="dn dib-ns" />
    {content}
  </main>
)

SplitLayout.propTypes = {
  heading: PropTypes.string,
  headingClassName: PropTypes.string,
  sidebar: PropTypes.element,
  content: PropTypes.element.isRequired,
  contentClassName: PropTypes.string,
  className: PropTypes.string
}

export default SplitLayout
