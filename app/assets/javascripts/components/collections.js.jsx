var CollectionHeaderBlank = React.createClass({
  render: function() {
    return <header className="col-7 container text-center">
      <h1 className="ib m0">{this.props.collection.name}</h1>
      <a href="#editCollection">
        <IconEdit classes="edit-btn ib modalTrigger" />
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
      <div className="col-10 center collection-header-container">
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
