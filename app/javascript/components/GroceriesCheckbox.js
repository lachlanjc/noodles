import React, { Component } from 'react'
import PropTypes from 'prop-types'

import Icon from './Icon'

class GroceriesCheckbox extends Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    id: PropTypes.number.isRequired,
    completedAt: PropTypes.string,
    showCompleted: PropTypes.bool
  }

  constructor(props) {
    super(props)
    this.state = {
      completedAt: props.completedAt || null,
      deleted: false
    }
  }

  componentDidMount() {
    this.checkbox.onclick = e => {
      this.handleClick(e)
    }
    this.delete.onclick = e => {
      this.handleDelete(e)
    }
  }

  handleClick(e) {
    this.setState(a => ({
      completedAt: _.isEmpty(a.completedAt) ? new Date().toISOString() : null
    }))

    const data = JSON.stringify({
      grocery: { completed_at: this.state.completedAt }
    })
    $.put({ url: `/groceries/${this.props.id}`, method: 'PATCH', data })
  }

  handleDelete(e) {
    e.preventDefault()
    $.ajax({
      url: `/groceries/${this.props.id}`,
      method: 'DELETE'
    }).done(() => {
      this.setState({ deleted: true })
    })
  }

  render() {
    const {
      name,
      id,
      completedAt,
      showCompleted = false,
      ...props
    } = this.props
    const completed = !_.isEmpty(this.state.completedAt)
    const date = showCompleted && new Date(completedAt).toLocaleDateString()
    const cx = {
      root: {
        position: 'relative',
        cursor: 'pointer',
        lineHeight: '1.125',
        textDecoration: completed && 'line-through',
        display: this.state.deleted && 'none'
      },
      box: {
        boxSizing: 'border-box',
        width: 22,
        height: 22,
        backgroundColor: completed ? '#00cd57' : '#f9fafc',
        borderRadius: 6,
        borderStyle: completed ? null : 'solid',
        borderColor: '#8492a6',
        borderWidth: 1,
        transition: 'background-color .2s ease-out'
      }
    }
    return (
      <li className="groceries__item f4 flex fac w-100 mtm" style={cx.root}>
        <div
          className="flex fac flex-auto"
          ref={a => {
            this.checkbox = a
          }}
        >
          <div className="flex fac fjc fsn mrs" style={cx.box}>
            <Checkmark className={completed ? 'dib' : 'dn'} size={14} />
          </div>
          <span className="man">{name}</span>
        </div>
        <div className="flex fac" ref={a => (this.delete = a)}>
          <Icon
            icon="cancel"
            size={22}
            className="groceries__item__delete red mls"
            style={{ fill: 'currentColor' }}
          />
          {date && <span className="f5 grey-3 mls" children={date} />}
        </div>
      </li>
    )
  }
}

export default GroceriesCheckbox

const Checkbox = ({
  label,
  checked = false,
  strikethrough = false,
  metadata,
  handleDelete,
  ...props
}) => {
  const cx = {
    root: {
      position: 'relative',
      cursor: 'pointer',
      lineHeight: '1.125',
      textDecoration: strikethrough && 'line-through'
    },
    box: {
      boxSizing: 'border-box',
      width: 22,
      height: 22,
      backgroundColor: checked ? '#00cd57' : '#f9fafc',
      borderRadius: 6,
      borderStyle: checked ? null : 'solid',
      borderColor: '#8492a6',
      borderWidth: 1,
      transition: 'background-color .2s ease-out'
    }
  }
  return (
    <div className="f4 flex fac w-100 mtm" style={cx.root} {...props}>
      <div className="flex fac fjc fsn mrs" style={cx.box}>
        <Checkmark className={checked ? 'dib' : 'dn'} size={14} />
      </div>
      {!_.isEmpty(label) && <span className="man flex-auto">{label}</span>}
      <div className="flex fac">
        <Icon
          icon="cancel"
          size={22}
          className="delete-grocery red mls"
          style={{ fill: 'currentColor' }}
          onClick={handleDelete}
        />
        {!_.isEmpty(metadata) &&
          <span className="f5 grey-3 mls" children={metadata} />}
      </div>
    </div>
  )
}

Checkbox.propTypes = {
  label: PropTypes.string.isRequired,
  checked: PropTypes.bool,
  strikethrough: PropTypes.bool,
  metadata: PropTypes.string,
  handleDelete: PropTypes.func
}

const Checkmark = ({ size = 16, ...props }) => (
  <svg
    viewBox="0 0 32 32"
    alt="checkmark icon"
    style={{ width: size, height: size }}
    {...props}
  >
    <path d="M1 14 L5 10 L13 18 L27 4 L31 8 L13 26 z" fill="#f9fafc" />
  </svg>
)

Checkmark.propTypes = {
  size: PropTypes.number
}
