
const BlankSlate = ({
  margin,
  className,
  ...props
}) =>
  <article
    {...props}
    className={
      _.join([
        `measure border rounded pal tc mx-auto`,
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
  margin: React.PropTypes.string
}
