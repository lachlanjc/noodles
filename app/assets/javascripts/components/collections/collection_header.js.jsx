class CollectionHeader extends React.Component {
  componentDidMount() {
    activateModals()
  }

  render() {
    const coll = this.props.coll;

    let rootClass = 'col-12 bs-bb flex fac';
    let rootStyle = {};
    let actionsClass = 'caps h4 dn-p mtm';
    if (!_.isEmpty(coll.photo)) {
      rootClass += ' image-header relative inline-with-nav pvl bg-cover bg-center bg-no-repeat';
      rootStyle.backgroundImage = `url(${coll.photo_url})`;
      actionsClass += ' mbm db white';
    } else {
      rootClass += ' tc grey-4 pvm';
    }

    return (
      <header className={rootClass} style={{backgroundImage: `url(${coll.photo})`}}>
        <div className='sm-col-12 md-col-8 mx-auto phm mw7'>
          <h1 className='coll-name man h0'>{coll.name}</h1>
          {!_.isEmpty(coll.description) ? <p className='h3 mts mbn coll-desc'>{coll.description}</p> : null}
          {this.props.pub ?
            <p className='mts mbs coll-desc h4'>Published by {coll.publisher}</p>
          : null}
          <div className={actionsClass}>
            {this.props.edit ?
              <a name='editCollection' href='#editCollection' className='link-reset' data-behavior='modal_trigger'>Edit · </a>
            : null}
            <a name='shareCollection' href='#shareCollection' className='link-reset' data-behavior='modal_trigger'>Share</a>
          </div>
        </div>
      </header>
    )
  }
}
