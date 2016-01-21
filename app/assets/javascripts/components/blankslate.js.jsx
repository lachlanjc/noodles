class BlankSlate extends React.Component {
  render() {
    const width = this.props.width || 6
    return (
      <article className={`md-col-${width} border bg-darken-1 rounded ${this.props.margin || 'mvl'} pal tc mx-auto`}>
        {this.props.children}
      </article>
    )
  }
}

BlankSlate.propTypes = {
  width: React.PropTypes.number,
  margin: React.PropTypes.string
}
