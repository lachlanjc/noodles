
const FlashContainer = ({
  flashes
}) => {
  const sx = {
    boxSizing: 'border-box',
    width: '100%',
    position: 'absolute',
    marginLeft: 'auto',
    marginRight: 'auto',
    textAlign: 'center',
    zIndex: 8
  }
  return (
    <section style={sx}>
      {_.map(flashes, (flash, i) =>
        <FlashMessage
          key={`flash-${i}`}
          type={flash[0]}
          message={flash[1]}
        />
      )}
    </section>
  )
}

FlashContainer.propTypes = {
  flashes: React.PropTypes.array.isRequired
}

const FlashIcon = ({ type }) => {
  let icon, color
  if (type === 'success' || type === 'info') {
    icon = 'check'
    color = 'green'
  }
  if (type === 'danger') {
    icon = 'close'
    color = 'red'
  }
  const sx = {
    position: 'relative',
    top: 6,
    marginRight: 6
  }
  if (!_.isEmpty(icon)) {
    return (
      <Icon
        icon={icon}
        style={sx}
        className={`fill-${color}`}
      />
    )
  } else {
    return null
  }
}

const FlashMessage = ({
  message,
  type
}) => {
  const height = 36
  const sx = {
    backgroundColor: 'rgba(0,0,0,.75)',
    color: '#fff',
    display: 'inline-block',
    position: 'relative',
    top: -height,
    borderRadius: height / 2,
    lineHeight: `${height}px`,
    paddingLeft: N.space[3],
    paddingRight: N.space[3]
  }
  const cx = 'dn-p'
  return (
    <div role='alertdialog' data-behavior='flash' className={cx} style={sx}>
      {type && <FlashIcon type={type} />}
      {message}
    </div>
  )
}
