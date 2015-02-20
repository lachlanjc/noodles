var AnnouncementItem = React.createClass({
  render: function() {
    return <div className="bg-white rounded shadow mb2 py2 px3">
      <AnnouncementBody data={this.props.data} />
    </div>
  }
});
var AnnouncementBody = React.createClass({
  render: function() {
    return <div>
      <h1 className="mt1 mb0 inline-block">{this.props.data.title}</h1>
      <a className="right grey-5 h5 mt2 caps bold" href={this.props.data.url}>Permalink</a>
      <p className="grey-3">Published by Lachlan on {this.props.data.created_at}</p>
      <div className="text" dangerouslySetInnerHTML={{ __html: this.props.data.body_rendered }}></div>
    </div>
  }
});
var AnnouncementList = React.createClass({
  render: function() {
    return (
      <article className="container col-7">
        <h1>Noodles keeps getting better.</h1>
        <h2 className="grey-3 mt0 mb3">Check back here for the latest updates.</h2>
        {this.props.announcements.map(function(announcement) {
           return <AnnouncementItem key={announcement.id} data={announcement}/>;
        })}
      </article>
    );
  }
});
