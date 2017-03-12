
const Document = ({
  className,
  measure,
  mw,
  ...props
}) =>
  <main
    {...props}
    className={N.cxs([
      'document',
      measure && 'measure',
      mw && `mw${mw || 7}`,
      className
    ])}
  />

Document.propTypes = {
  className: React.PropTypes.string,
  measure: React.PropTypes.bool,
  mw: React.PropTypes.oneOf([5, 6, 7, 8])
}
