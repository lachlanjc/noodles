class AnnouncementItem extends React.Component {
  render() {
    return (
      <div className="bg-white rounded shadow mb2 py2 px3">
        <AnnouncementBody data={this.props.data} />
      </div>
    )
  }
}

class AnnouncementBody extends React.Component {
  render() {
    return (
      <div>
        <h1 className="mt1 mb0 inline-block">{this.props.data.title}</h1>
        <p className="grey-3">
          Published {this.props.data.created_at} · {""}
          <a className="link-reset" href={"/announcements/" + this.props.data.id.toString()}>Permalink</a>
        </p>
        <div className="text" dangerouslySetInnerHTML={{ __html: this.props.data.body_rendered }}></div>
      </div>
    )
  }
}

class AnnouncementList extends React.Component {
  render() {
    return (
      <main className="sm-col-11 md-col-8 mx-auto py2">
        <h1>Noodles keeps getting better.</h1>
        <h2 className="grey-3 mt0 mb3">Check back here for the latest updates.</h2>
        {this.props.announcements.map(function(announcement) {
           return <AnnouncementItem key={"announcement-" + announcement.id} data={announcement}/>;
        })}
      </main>
    )
  }
}
