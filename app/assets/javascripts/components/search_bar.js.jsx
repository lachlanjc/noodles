class SearchBar extends React.Component {
  render() {
    const props = _.omit(this.props, 'className')
    return (
      <section role='search'
               className={`${this.props.className} flex bg-white rounded shadow phs dn-p`}>
        <Icon icon='search' className='fill-grey-4 mts fsn' />
        <input type='text'
               className='text-input invisible-input'
               style={{height: 36}}
               {...props} />
      </section>
    )
  }
}
