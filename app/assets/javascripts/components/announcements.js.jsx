var AnnouncementItem = React.createClass({
  render: function() {
    return <div className="bg-white rounded shadow mb2 p3">
      <AnnouncementBody data={this.props.data} />
    </div>
  }
});
var AnnouncementBody = React.createClass({
  render: function() {
    return <div>
      <h1 className="m0 inline">{this.props.data.title}</h1>
      <a className="float-right grey-5 h5 mt1 caps bold" href={this.props.data.url}>Permalink</a>
      <p className="grey-3">Published by Lachlan on {this.props.data.created_at}</p>
      <div className="text" dangerouslySetInnerHTML={{ __html: this.props.data.body_rendered }}></div>
    </div>
  }
});
var AnnouncementList = React.createClass({
  render: function() {
    return (
      <article className="col-7">
        <h1>Noodles keeps getting better.</h1>
        <h2 className="text-muted mt0 mb3">Check back here for the latest updates.</h2>
        {this.props.announcements.map(function(announcement) {
           return <AnnouncementItem key={announcement.id} data={announcement}/>;
        })}
      </article>
    );
  }
});
