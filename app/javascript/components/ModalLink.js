import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Button from './Button'

class ModalLink extends Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    is: PropTypes.string
  }

  componentDidMount() {
    totalModalize()
  }

  render() {
    const { name, is = 'a', ...props } = this.props
    const Tag = is == 'btn' ? Button : is
    return <Tag {...props} href={`#${name}`} data-behavior="modal_trigger" />
  }
}

export default ModalLink
