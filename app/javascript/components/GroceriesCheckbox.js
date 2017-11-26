import React, { Component } from 'react'
import PropTypes from 'prop-types'

const headers = new Headers({
  'X-Requested-With': 'XMLHttpRequest',
  'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
  'Content-Type': 'application/json',
  Accept: 'application/json'
})

class GroceriesCheckbox extends Component {
  static propTypes = {
    name: PropTypes.string.isRequired,
    id: PropTypes.number.isRequired,
    completedAt: PropTypes.string
  }

  constructor(props) {
    super(props)
    this.state = {
      completedAt: props.completedAt || null
    }
  }

  componentDidMount() {
    this.checkbox.onclick = e => {
      this.handleClick(e)
    }
  }

  handleClick(e) {
    this.setState(a => ({
      completedAt: _.isEmpty(a.completedAt) ? new Date().toISOString() : null
    }))

    const body = JSON.stringify({
      grocery: { completed_at: this.state.completedAt }
    })
    fetch(`/groceries/${this.props.id}`, { method: 'PATCH', headers, body })
  }

  render() {
    const { name, id, completedAt, ...props } = this.props
    const completed = !_.isEmpty(this.state.completedAt)
    return (
      <li
        ref={a => {
          this.checkbox = a
        }}
      >
        <Checkbox label={name} checked={completed} strikethrough={completed} />
      </li>
    )
  }
}

export default GroceriesCheckbox

const Checkbox = ({
  label,
  checked = false,
  strikethrough = false,
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
      {label && <span className="man">{label}</span>}
    </div>
  )
}

Checkbox.propTypes = {
  label: PropTypes.string.isRequired,
  checked: PropTypes.bool,
  strikethrough: PropTypes.bool
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
