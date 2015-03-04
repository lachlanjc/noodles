var CollectionIndex = React.createClass({
  render: function() {
    return (
      <article className="sm-col-11 md-col-7 mx-auto">
        <h1 className="center">Collections</h1>
        <div className="collection-list">
          {this.props.collections.map(function(collection) {
            return <CollectionItem key={collection.id} data={collection} />;
          })}
          {this.props.collections.length === 0 ?
            <div className="col-6 well text center bg-grey-6 border rounded p2 mx-auto">
              You don't have any collections yet.
              <a href="#newCollection" className="modalTrigger">Create your first!</a>
            </div>
          : null}
        </div>
      </article>
    );
  }
});

var CollectionItem = React.createClass({
  render: function() {
    var photo_url = this.props.data.photo_url;

    var imgClass = " bg-white rounded shadow p2";
    var imgStyle;
    if (photo_url.length > 0) {
      imgClass = " has-img bg-center bg-no-repeat bg-cover";
      var imgStyle = {
        backgroundImage: "url(" + photo_url + ")"
      }
    }

    return (
      <a href={this.props.data.url} className="link-reset">
        <div className={"collection-preview rounded shadow mb2 py3" + imgClass} style={imgStyle}>
          <div className="collection-preview-container center">
            <h2 className="collection-name m0 h1">{this.props.data.name}</h2>
            <div className="lead">{this.props.data.description}</div>
          </div>
        </div>
      </a>
    )
  }
});

var CollectionHeader = React.createClass({
  render: function() {
    var photo_url = this.props.collection.photo_url;
    var headerStyle, headerClass;
    var actionClass = "grey-4 py2"
    var nameClass = "h1";
    if (photo_url.length > 0) {
      nameClass = "h0";
      headerClass = "has-img bg-center bg-no-repeat bg-cover mb2";
      actionClass = "right-align p1 block white p2 mb2 ";
      var headerStyle = {
        backgroundImage: "url(" + photo_url + ")"
      }
    }

    return (
      <header className={"collection-header full-width center " + headerClass} style={headerStyle}>
        <div className={"caps h4 " + actionClass}>
          {this.props.showEdit === true ?
            <a href="#editCollection" className="modalTrigger link-reset">Edit · </a>
          : null}
          <a href="#shareCollection" className="modalTrigger link-reset">Share</a>
        </div>
        <h1 className={"inline-block collection-name m0 " + nameClass}>{this.props.collection.name}</h1>
        <div className="lead">{this.props.collection.description}</div>
        {this.props.showPublisher === true ?
          <div className="mt1 mb4 h4 grey-3 inline-block">Published by {this.props.collection.publisher}</div>
        : null}
      </header>
    )
  }
});
