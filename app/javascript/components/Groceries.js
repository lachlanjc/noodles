import React from 'react'
import PropTypes from 'prop-types'

import Document from './Document'
import SuperHeader from './SuperHeader'
import Button from './Button'
import Spacer from './Spacer'
import GroceriesBlankSlate from './GroceriesBlankSlate'
import GroceriesList from './GroceriesList'
import GroceriesForm from './GroceriesForm'
import ModalLink from './ModalLink'

const mailto = items =>
  `mailto:?subject=Grocery%20list&body=${encodeURIComponent(_.join(_.map(items, 'name'), '\n') + '\n\nList from Noodles: https://getnoodl.es/')}`

const Groceries = ({ groceries }) => (
  <div>
    <Document mw={6} className="mbn">
      <Button
        href="/groceries/new"
        color="grey-3"
        sm
        style={{ float: 'right', marginTop: 4 }}
      >
        Add item
      </Button>
      <SuperHeader className="sans f1-ns mvn-ns">Grocery List</SuperHeader>
      {_.isEmpty(groceries)
        ? <GroceriesBlankSlate />
        : [
            <GroceriesList items={groceries} key="list" />,
            <GroceriesForm key="add" />
          ]}
    </Document>
    <footer className="flex fjc mtm mbxl">
      <ModalLink is="btn" color="grey-3" name="sms" sm>Use SMS</ModalLink>
      <Spacer x={16} />
      <Button color="grey-3" sm href={mailto(groceries)}>
        Email this list
      </Button>
    </footer>
  </div>
)

export default Groceries
