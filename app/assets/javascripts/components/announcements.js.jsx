var AnnouncementItem = React.createClass({
  render: function() {
    return <div className="bg-white rounded shadow mb2 p3">
      <h1 className="m0"><a href={this.props.data.url}>{this.props.data.title}</a></h1>
      <p className="text-muted">Published by Lachlan on {this.props.data.created_at}</p>
      <div className="text" dangerouslySetInnerHTML={{ __html: this.props.data.body_rendered }} />
    </div>
  }
});
var AnnouncementBody = React.createClass({
  render: function() {
    return <div className="document col-7">
      <h1 className="m0">{this.props.announcement.title}</h1>
      <p className="text-muted">Published by Lachlan on {this.props.announcement.created_at}</p>
      <div className="text" dangerouslySetInnerHTML={{ __html: this.props.announcement.body_rendered }}></div>
      <hr />
      <BioLachlan />
      <hr />
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
