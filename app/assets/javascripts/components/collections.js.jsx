var CollectionIndex = React.createClass({
  render: function() {
    return (<article className="col-7">
      <h1 className="text-center">Collections</h1>
      <div className="collection-list">
        {this.props.collections.map(function(collection) {
          return <CollectionItem key={collection.id} data={collection} />;
        })}
        {(this.props.collections.length === 0) ? <div className="col-6 well mx-auto">You don't have any collections yet. <a href="#newCollection" className="modalTrigger">Create one!</a></div> : null}
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
          <h2 className="collection-name">{this.props.data.name}</h2>
          <div className="collection-description lead mb1">{this.props.data.description ? this.props.data.description : null}</div>
        </div>
      </div>
    </a>
  }
});


var CollectionHeaderBlank = React.createClass({
  render: function() {
    return <header className="col-7 container text-center">
      <h1 className="ib m0">{this.props.collection.name}</h1>
      <a href="#editCollection" className="modalTrigger">
        <IconEdit classes="edit-btn ib" />
      </a>
      <div className="text m1-btm">{this.props.collection.description}</div>
    </header>
  }
});

var CollectionHeaderImg = React.createClass({
  render: function() {
    var collectionHeaderStyle = {
      backgroundImage: 'url(' + this.props.collection.photo_url + ')'
    };

    return <div className="collection-header has-img" style={collectionHeaderStyle}>
      <div className="col-10 mx-auto collection-header-container">
        <h1 className="collection-name ib">
          {this.props.collection.name}
        </h1>
        <a href="#editCollection" className="modalTrigger">
          <IconEdit classes="edit-btn-glass ib m-small-left" />
        </a>
        <div className="collection-description lead">
          {this.props.collection.description}
        </div>
      </div>
    </div>
  }
});
