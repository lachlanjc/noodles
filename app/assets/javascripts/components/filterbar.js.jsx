
const FilterBar = ({ ...props }) => (
  <section {...props} role='menubar' className='filterbar tc' />
)

const FilterBarItem = ({ active, view, className, ...props }) => {
  let cx = [
    'filterbar__item dib phm pointer',
    className
  ]
  if (_.isEqual(active, view)) {
    cx.push('bg-orange white white-hover b')
  } else {
    cx.push('grey-1')
  }
  cx = _.join(cx, ' ')

  return (
    <a
      {...props}
      role='menuitem'
      className={cx}
    />
  )
}

FilterBarItem.propTypes = {
  active: React.PropTypes.string.isRequired,
  view: React.PropTypes.string.isRequired,
  className: React.PropTypes.string,
}
