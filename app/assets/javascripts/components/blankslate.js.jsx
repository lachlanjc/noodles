
const BlankSlate = ({ width, margin, ...props }) => (
  <article
    className={`md-col-${width || 6} border bg-grey-4 rounded ${margin || 'mvl'} pal tc mx-auto`}
    {...props}
  />
)

BlankSlate.propTypes = {
  width: React.PropTypes.number,
  margin: React.PropTypes.string
}
