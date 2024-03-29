import React from 'react'
import PropTypes from 'prop-types'

import SidebarModule, {
  SidebarModuleHeading,
  SidebarModuleList,
  SidebarModuleListItem
} from './SidebarModule'
import GroceriesForm from './GroceriesForm'

const GroceriesMini = ({ groceries, ...props }) => (
  <SidebarModule {...props}>
    <SidebarModuleHeading>
      <a href="/groceries" className="blue">
        Grocery list
      </a>
    </SidebarModuleHeading>
    {!_.isEmpty(groceries) && (
      <SidebarModuleList
        children={_.map(groceries, (item, i) => (
          <SidebarModuleListItem name={item.name} key={item.name + i} />
        ))}
      />
    )}
    <GroceriesForm
      hideSubmit={!_.isEmpty(groceries)}
      makeSuggestions={false}
      autoFocus={false}
      style={{}}
    />
  </SidebarModule>
)

GroceriesMini.propTypes = {
  groceries: PropTypes.array.isRequired,
  hidden: PropTypes.bool
}

export default GroceriesMini
