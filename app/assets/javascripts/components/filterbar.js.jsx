class FilterBar extends React.Component {
  render() {
    return (
      <section role='menubar' className='filterbar tc'>
        {this.props.children}
      </section>
    )
  }
}

class FilterBarItem extends React.Component {
  render() {
    let classes = 'filterbar__item dib phm pointer ';
    if (this.props.active === this.props.view) {
      classes += 'bg-orange white white-hover b'
    } else {
      classes += 'grey-1'
    }

    return (
      <a role='menuitem' className={classes} {...this.props}>
        {this.props.name}
      </a>
    )
  }
}

FilterBarItem.propTypes = {
  active: React.PropTypes.string.isRequired,
  view: React.PropTypes.string.isRequired,
  name: React.PropTypes.string.isRequired
}
