import React from 'react'
import PropTypes from 'prop-types'

import SidebarModule, {
  SidebarModuleHeading,
  SidebarModuleList,
  SidebarModuleListItem
} from './SidebarModule'

const CollectionsMini = ({ collections, ...props }) => (
  <SidebarModule {...props}>
    <SidebarModuleHeading>
      <a href="/collections" className="blue">Collections</a>
    </SidebarModuleHeading>
    <SidebarModuleList>
      {_.map(collections, coll => (
        <SidebarModuleListItem
          name={coll.name}
          path={coll.path}
          key={coll.path}
        />
      ))}
    </SidebarModuleList>
    {_.isEmpty(collections) &&
      <p className="grey-3">
        No collections yet
        {' – '}
        <a href="/collections?new_collection=true" className="blue">
          create your first!
        </a>
      </p>}
  </SidebarModule>
)

CollectionsMini.propTypes = {
  collections: PropTypes.array.isRequired,
  hidden: PropTypes.bool
}

export default CollectionsMini
