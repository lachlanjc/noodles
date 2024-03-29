import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Icon from './Icon'
import Button from './Button'
import allSuggestions from './GroceryAutocomplete'

class GroceriesForm extends Component {
  static propTypes = {
    hideSubmit: PropTypes.bool,
    makeSuggestions: PropTypes.bool,
    autoFocus: PropTypes.bool
  }

  state = { name: '', suggestions: [] }

  componentDidMount() {
    // onClick isn't working, so defined in application CoffeeScript
    N.updateGroceryName = (a, b) => {
      this.updateName(a, b)
      this.input.focus()
    }
  }

  updateName = (name, makeSuggestions) => {
    this.setState({ name })
    if (makeSuggestions) {
      this.makeSuggestions(name)
    } else {
      this.setState({ suggestions: [] })
    }
  }

  makeSuggestions = name => {
    const searchText = _.trim(_.lowerCase(name))
    if (_.isEmpty(searchText) || searchText.length < 2) {
      this.setState({ suggestions: [] })
    } else {
      const suggestions = _.filter(allSuggestions, l =>
        _.lowerCase(l).match(searchText)
      )
      this.setState({ suggestions })
    }
  }

  render() {
    const {
      hideSubmit = false,
      makeSuggestions = true,
      autoFocus = true,
      ...props
    } = this.props
    let csrfToken
    const node = document.querySelector("head meta[name='csrf-token']")
    if (node && node.content) csrfToken = _.toString(node.content)
    const { name, suggestions } = this.state
    return (
      <form
        action="/groceries"
        method="POST"
        acceptCharset="UTF-8"
        className="dn-p mtm"
        onSubmit={N.track('add-grocery', { name })}
        {...props}
      >
        <input type="hidden" name="authenticity_token" value={csrfToken} />
        <input type="hidden" name="utf8" value="&#x2713;" />
        <div className="flex fac w-100" style={{ marginTop: 6 }}>
          <Icon glyph="plus" size={22} className="grey-3" />
          <input
            name="grocery[name]"
            id="grocery_name"
            placeholder="Add an item…"
            ref={a => (this.input = a)}
            onChange={e => this.updateName(e.target.value, true)}
            value={name}
            autoFocus={autoFocus}
            className={`text-input flex-auto mhs f4`}
            style={{
              borderWidth: '0 0 1px 0',
              borderRadius: 0,
              background: 'transparent',
              paddingLeft: 0,
              paddingTop: 4,
              paddingBottom: 4
            }}
          />
          {!hideSubmit && (
            <Button is="input" type="submit" color="blue" sm value="Save" />
          )}
        </div>
        {makeSuggestions && !_.isEmpty(suggestions) && (
          <div
            className="mts flex flex-rows fas lh-title"
            children={[
              <div
                className="flex-i fac mrs"
                style={{ paddingTop: 4 }}
                key="icon-assistant"
              >
                <Icon glyph="rep" size={22} className="grey-3" />
              </div>,
              _.map(suggestions, (item, i) => (
                <span
                  className="list__item"
                  children={item}
                  data-behavior="grocery_suggestion"
                  key={`item-${item}-${i}`}
                />
              ))
            ]}
          />
        )}
      </form>
    )
  }
}

export default GroceriesForm
