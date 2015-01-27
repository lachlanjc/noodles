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
      <div>
        {this.props.announcements.map(function(announcement) {
           return <AnnouncementItem key={announcement.id} data={announcement}/>;
        })}
      </div>
    );
  }
});
