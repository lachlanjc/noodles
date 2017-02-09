
const Spacer = ({
  x,
  y,
  style,
  ...props
}) => {
  const sx = {
    width: x,
    height: y,
    ...style
  }
  return <div {...props} style={sx} />
}

Spacer.propTypes = {
  x: React.PropTypes.number,
  y: React.PropTypes.number,
  style: React.PropTypes.object
}
