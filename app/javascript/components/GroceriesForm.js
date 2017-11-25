import React from 'react'
import PropTypes from 'prop-types'

import Icon from './Icon'
import Button from './Button'

const GroceriesForm = ({ hideSubmit = false, ...props }) => {
  let csrfToken
  const node = document.querySelector("head meta[name='csrf-token']")
  if (node && node.content) csrfToken = _.toString(node.content)
  return (
    <form
      action="/groceries"
      method="POST"
      acceptCharset="UTF-8"
      className="flex fac w-100 mts"
      style={{ paddingTop: 4 }}
      {...props}
    >
      <input type="hidden" name="authenticity_token" value={csrfToken} />
      <input type="hidden" name="utf8" value="&#x2713;" />
      <Icon icon="add" size={22} className="fill-grey-3" />
      <input
        name="grocery[name]"
        id="grocery_name"
        placeholder="Add an item…"
        className="text-input flex-auto mhs"
        style={{
          borderWidth: '0 0 1px 0',
          borderRadius: 0,
          background: 'transparent',
          paddingLeft: 0,
          paddingTop: 4,
          paddingBottom: 4
        }}
      />
      {!hideSubmit &&
        <Button is="input" type="submit" color="blue" sm value="Save" />}
    </form>
  )
}

GroceriesForm.propTypes = {
  hideSubmit: PropTypes.bool
}

export default GroceriesForm
