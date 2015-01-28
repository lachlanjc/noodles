var AnnouncementItem = React.createClass({
  render: function() {
    return <div className="panel">
      <h1 className="m0">{this.props.data.title}</h1>
      <p className="text-myted">Published by Lachlan on {this.props.data.created_at}</p>
      <div className="text" dangerouslySetInnerHTML={{ __html: this.props.data.body_rendered }}></div>
    </div>
  }
});
var AnnouncementList = React.createClass({
  render: function() {
    return (
      <article className="col-7">
        <h1>Noodles keeps getting better.</h1>
        <h2 class="text-muted">Check back here for the latest updates.</h2>
        <hr />
        {this.props.announcements.map(function(announcement) {
           return <AnnouncementItem key={announcement.id} data={announcement}/>;
        })}
      </article>
    );
  }
});
