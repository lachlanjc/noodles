var CollectionIndex = React.createClass({
  render: function() {
    return (<article className="col-7">
      <h1 className="text-center">Collections</h1>
      <div className="collection-list">
        {this.props.collections.map(function(collection) {
          return <CollectionItem key={collection.id} data={collection} />;
        })}
        {(this.props.collections.length === 0) ? <div className="col-6 well text text-center bg-grey-6 border rounded p2 mx-auto">You don't have any collections yet. <a href="#newCollection" className="modalTrigger">Create your first!</a></div> : null}
      </div>
    </article>);
  }
});

var CollectionItem = React.createClass({
  render: function() {
    var photo_url = this.props.data.photo_url;

    var imgClass = " bg-white rounded shadow p2";
    var imgStyle;
    if (photo_url.length > 0) {
      imgClass = " has-img"; // overrides white panel
      var imgStyle = {
        backgroundImage: "url(" + photo_url + ")"
      }
    }

    return <a href={this.props.data.url} className="link-reset">
      <div className={"collection-preview rounded shadow mb2 py3" + imgClass} style={imgStyle}>
        <div className="collection-preview-container text-center">
          <h2 className="collection-name m0">{this.props.data.name}</h2>
          <div className="lead mt1">{this.props.data.description ? this.props.data.description : null}</div>
        </div>
      </div>
    </a>
  }
});

var CollectionHeader = React.createClass({
  render: function() {
    var photo_url = this.props.collection.photo_url;

    var headerClass, headerStyle;
    var actionBtnClass = "btn-action";
    if (photo_url.length > 0) {
      headerClass = "has-img mb2";
      actionBtnClass = "btn-action glass";
      var headerStyle = {
        backgroundImage: "url(" + photo_url + ")"
      }
    }

    return <header className={"collection-header full-width text-center py3 " + headerClass} style={headerStyle}>
      <h1 className="ib collection-name m0">{this.props.collection.name}</h1>
      {this.props.showEdit === true ?
        <a href="#editCollection" className="modalTrigger">
          <IconEdit classes={"ib ml1 " + actionBtnClass} />
        </a>
      : null}
      <a href="#shareCollection" className="modalTrigger">
        <IconShare classes={"ib ml1 " + actionBtnClass} />
      </a>
      <div className="lead">{this.props.collection.description}</div>
      {this.props.showPublisher === true ?
        <div className="mt2 mb0 h4 grey-3">Published by {this.props.collection.publisher}</div>
      : null}
    </header>
  }
});
