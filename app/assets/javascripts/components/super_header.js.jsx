
const SuperHeader = ({
  className = 'orange',
  style,
  ...props
}) => {
  const sx = {
    fontWeight: '800',
    lineHeight: 1,
    marginTop: 0,
    paddingBottom: N.space[2],
    ...style
  }
  const cx = [
    'superheader f1 f0-ns mbm mbl-ns border-bottom',
    className
  ].join(' ')
  return (
    <h1
      {...props}
      style={sx}
      className={cx}
    />
  )
}

SuperHeader.propTypes = {
  className: React.PropTypes.string,
  style: React.PropTypes.object
}
