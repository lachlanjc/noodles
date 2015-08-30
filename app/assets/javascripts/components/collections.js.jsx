class CollectionIndex extends React.Component {
  render() {
    return (
      <article className="sm-col-11 md-col-7 mx-auto">
        <h1 className="center">Collections</h1>
        <div className="collection-list">
          {this.props.collections.map(function(collection) {
            return <CollectionItem key={collection.id} data={collection} />;
          })}
          {this.props.collections.length === 0 ?
            <div className="md-col-8 mx-auto mt3 text center border bg-white rounded p3">
              <h3 className="mt0">You don't have any collections yet.</h3>
              <p>Collections help you organize your recipes.</p>
              <p>You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.</p>
              <p><a href="#newCollection" className="btn bg-blue mt2" data-behavior="modal_trigger">Create your first collection</a></p>
            </div>
          : null}
        </div>
      </article>
    )
  }
}

class CollectionItem extends React.Component {
  render() {
    const photo_url = this.props.data.photo_url;

    let imgClass = " bg-white rounded shadow p2";
    let imgStyle;
    if (photo_url.length > 0) {
      imgClass = " has-img bg-center bg-no-repeat bg-cover";
      imgStyle = {
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
}

class CollectionHeader extends React.Component {
  render() {
    const photo_url = this.props.collection.photo_url;
    let rootStyle, actionClass;
    let rootClass = "grey-4 py2"
    let nameClass = "h1";
    if (photo_url.length > 0) {
      rootClass = "has-img bg-center bg-no-repeat bg-cover mb1";
      nameClass = "h0";
      actionClass = "right-align p1 block white p2 mb2 ";
      rootStyle = {
        backgroundImage: "url(" + photo_url + ")"
      }
    }

    return (
      <header className={"collection-header full-width center " + rootClass} style={rootStyle}>
        <div className={"caps h4 " + actionClass}>
          {this.props.show_edit === true ?
            <a href="#editCollection" className="link-reset" data-behavior="modal_trigger">Edit · </a>
          : null}
          <a href="#shareCollection" className="link-reset" data-behavior="modal_trigger">Share</a>
        </div>
        <h1 className={"inline-block collection-name m0 " + nameClass}>{this.props.collection.name}</h1>
        <div className="h3 mt1 mb0">{this.props.collection.description}</div>
        {this.props.show_pub === true ?
          <div className="mt1 mb1 h4 grey-3">Published by {this.props.collection.publisher}</div>
        : null}
      </header>
    )
  }
}
