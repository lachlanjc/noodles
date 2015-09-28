class BlankSlate extends React.Component {
  render() {
    const width = this.props.width || '6'
    return (
      <article className={`md-col-${width} border bg-darken-1 rounded mt3 mb3 p3 center mx-auto`}>
        {this.props.children}
      </article>
    )
  }
}
