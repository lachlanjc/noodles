import React from 'react'
import PropTypes from 'prop-types'

const SidebarModule = ({ hidden = false, ...props }) => (
  <div className={hidden ? 'dn' : 'dn db-ns mtm'} {...props} />
)

SidebarModule.propTypes = {
  hidden: React.PropTypes.bool
}

export default SidebarModule

export const SidebarModuleHeading = props => (
  <h2 className="f3 grey-2 pvs border-bottom mtn mbs" {...props} />
)

export const SidebarModuleList = props => (
  <ul className="list-reset" {...props} />
)

export const SidebarModuleListItem = ({ name, path }) => (
  <li className="mts">
    <a className="blue" href={path} children={name} />
  </li>
)

SidebarModuleListItem.propTypes = {
  name: PropTypes.string.isRequired,
  path: PropTypes.string.isRequired
}
