
const Avatar = ({
  src,
  size = 48,
  style,
  ...props
}) => (
  <img
    {...props}
    src={src}
    style={{
      width: size,
      height: size,
      borderRadius: size / 2,
      display: 'inline-block',
      flexShrink: 0,
      ...style
    }}
  />
)

Avatar.propTypes = {
  src: React.PropTypes.string.isRequired,
  size: React.PropTypes.number,
  style: React.PropTypes.object
}
