import React from 'react'
import PropTypes from 'prop-types'

import Button from './Button'

const ModalLink = ({ name, is = 'a', ...props }) => {
  const Tag = is == 'btn' ? Button : is
  return <Tag {...props} href={`#${name}`} data-behavior="modal_trigger" />
}

ModalLink.propTypes = {
  name: PropTypes.string.isRequired,
  is: PropTypes.string
}

export default ModalLink
