
const RecipeListComplication = ({
  tooltip,
  icon,
  ...props
}) => (
  <a
    {...props}
    className='mlm lh0 tooltipped'
    aria-label={tooltip}
    children={
      <Icon icon={icon} className='fill-grey-3' />
    }
  />
)

RecipeListComplication.propTypes = {
  tooltip: React.PropTypes.string.isRequired,
  icon: React.PropTypes.string.isRequired
}
