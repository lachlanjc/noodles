import React from 'react'
import PropTypes from 'prop-types'

import SidebarModule, {
  SidebarModuleHeading,
  SidebarModuleList,
  SidebarModuleListItem
} from './SidebarModule'

const GroceriesMini = ({ groceries, ...props }) => (
  <SidebarModule {...props}>
    <SidebarModuleHeading>
      <a href="/groceries" className="blue">Grocery list</a>
    </SidebarModuleHeading>
    {_.isEmpty(groceries)
      ? <p className="grey-3">
          Nothing on your grocery list yet!
        </p>
      : <SidebarModuleList
          children={_.map(groceries, (item, i) => (
            <SidebarModuleListItem name={item.name} key={item.name + i} />
          ))}
        />}
  </SidebarModule>
)

GroceriesMini.propTypes = {
  groceries: PropTypes.array.isRequired,
  hidden: PropTypes.bool
}

export default GroceriesMini
