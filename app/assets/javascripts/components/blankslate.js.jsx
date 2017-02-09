
const BlankSlate = ({ width, margin, className, ...props }) => (
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
)

BlankSlate.propTypes = {
  width: React.PropTypes.number,
  margin: React.PropTypes.string
}
