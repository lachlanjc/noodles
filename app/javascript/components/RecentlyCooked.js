import React from 'react'
import PropTypes from 'prop-types'

import SidebarModule, {
  SidebarModuleHeading,
  SidebarModuleList,
  SidebarModuleListItem
} from './SidebarModule'

const findRecents = recipes =>
  _.slice(_.sortBy(_.filter(recipes, 'last_cooked_at'), 'last_cooked_at'), 0, 5)

const RecentlyCooked = ({ recipes, ...props }) => (
  <SidebarModule {...props}>
    <SidebarModuleHeading>Recently cooked</SidebarModuleHeading>
    <SidebarModuleList>
      {_.map(findRecents(recipes), recipe => (
        <SidebarModuleListItem
          name={recipe.title}
          path={recipe.path}
          key={recipe.path}
        />
      ))}
    </SidebarModuleList>
  </SidebarModule>
)

RecentlyCooked.propTypes = {
  recipes: PropTypes.array.isRequired
}

export default RecentlyCooked
