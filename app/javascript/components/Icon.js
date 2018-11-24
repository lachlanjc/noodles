import React from 'react'
import PropTypes from 'prop-types'

const Icon = require('@hackclub/icons').default

export default Icon

export const CollectionsIcon = ({ size = 32, ...props }) => (
  <svg
    fillRule="evenodd"
    clipRule="evenodd"
    strokeLinejoin="round"
    strokeMiterlimit="1.414"
    xmlns="http://www.w3.org/2000/svg"
    aria-labelledby="title"
    viewBox="0 0 32 32"
    preserveAspectRatio="xMidYMid meet"
    fill="currentColor"
    width={size}
    height={size}
    {...props}
  >
    <path d="M21.934 25.636c-1.478.284-3.354.365-5.934.364-2.58.001-4.456-.08-5.934-.364-1.402-.264-2.137-.66-2.589-1.113-.453-.452-.849-1.187-1.113-2.589C6.08 20.456 5.999 18.58 6 16c-.001-2.58.08-4.456.364-5.934.264-1.402.66-2.137 1.113-2.589.452-.453 1.187-.849 2.589-1.113C11.544 6.08 13.42 6 16 6s4.456.08 5.934.364c1.402.264 2.137.66 2.589 1.113.453.452.849 1.187 1.113 2.589C25.92 11.544 26 13.42 26 16s-.08 4.456-.364 5.934c-.264 1.402-.66 2.137-1.113 2.589-.452.453-1.187.849-2.589 1.113zM28 16c0 10.5-1.5 12-12 12S4 26.5 4 16 5.5 4 16 4s12 1.5 12 12z" />
    <g fillRule="non-zero">
      <path d="M14.821,15c0,-3 -1,-5 1,-5c2,0 1,2 1,5l0,2c0,3 1,5 -1,5c-2,0 -1,-2 -1,-5l0,-2Z" />
      <path d="M16.187,14.634c2.598,-1.5 3.83,-3.367 4.83,-1.634c1,1.732 -1.232,1.866 -3.83,3.366l-1.732,1c-2.598,1.5 -3.83,3.366 -4.83,1.634c-1,-1.733 1.232,-1.866 3.83,-3.366l1.732,-1Z" />
      <path d="M17.187,15.634c2.598,1.5 4.83,1.633 3.83,3.366c-1,1.732 -2.232,-0.134 -4.83,-1.634l-1.732,-1c-2.598,-1.5 -4.83,-1.634 -3.83,-3.366c1,-1.733 2.232,0.134 4.83,1.634l1.732,1Z" />
    </g>
  </svg>
)

export const AllIcons = () => (
  <div
    style={{
      display: 'grid',
      gridTemplateColumns: 'repeat(auto-fill, minmax(48px, 1fr))',
      gridGap: 16
    }}
  >
    {_.keys(glyphs).map(key => (
      <Icon glyph={key} size={48} key={key} />
    ))}
  </div>
)
