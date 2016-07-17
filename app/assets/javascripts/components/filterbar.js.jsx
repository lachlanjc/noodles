
const FilterBar = ({ ...props }) => (
  <section role='menubar' className='filterbar tc' {...props} />
)

const FilterBarItem = ({ active, view, className, ...props }) => {
  let cx
  if (_.isEqual(active, view)) {
    cx = 'bg-orange white white-hover b '
  } else {
    cx = 'grey-1 '
  }
  cx = `filterbar__item dib phm pointer ${cx} ${className}`

  return (
    <a
      role='menuitem'
      className={cx}
      {...props} />
  )
}

FilterBarItem.propTypes = {
  active: React.PropTypes.string.isRequired,
  view: React.PropTypes.string.isRequired,
  className: React.PropTypes.string,
}
