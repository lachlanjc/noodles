
const SearchBar = ({ count, className, children, ...props }) => {
  const inherit = _.omit(props, 'className')

  let label
  label = `Search ${(count !== 1 ? 'these' : 'for the')}`
  label = `${label} ${count} ${count !== 1 ? 'recipes' : 'recipe'}…`

  return (
    <section
      role='search'
      className={_.join(['flex fac mvs phm dn-p', className], ' ')}
      >
      <Icon icon='search' className='fill-grey-3 fsn' />
      <input
        type='text'
        placeholder={label}
        className='text-input invisible-input flex-auto'
        style={{ height: 36 }}
        {...inherit}
      />
      {children}
    </section>
  )
}

SearchBar.propTypes = {
  className: React.PropTypes.string,
  count: React.PropTypes.number.isRequired,
}
