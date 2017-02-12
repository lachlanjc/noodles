
const BlankSlate = ({
  width = 8,
   argin,
   className,
   ...props
}) =>
  <article
    {...props}
    className={
      _.join([
        `border rounded pal tc mx-auto`,
        width ? `md-col-${width}` : 'measure',
        margin || 'mvl',
        className
      ], ' ')
    }
    style={{
      borderWidth: 2,
      borderStyle: 'dashed'
    }}
  />

BlankSlate.propTypes = {
  width: React.PropTypes.isOneOf([ 6, 8, 10 ]),
  margin: React.PropTypes.string
}
