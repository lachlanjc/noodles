class AnnouncementItem extends React.Component {
  render() {
    return (
      <div className='bg-white rounded shadow mb2 py2 px3'>
        <AnnouncementBody data={this.props.data} />
      </div>
    )
  }
}

class AnnouncementBody extends React.Component {
  render() {
    return (
      <div>
        <h1 className='mt0 mb0 inline-block'>
          <a href={'/announcements/' + this.props.data.id.toString()}>
            {this.props.data.title}
          </a>
        </h1>
        <p className='grey-3'>
          Published on {this.props.data.created_at}
        </p>
        <div className='text' dangerouslySetInnerHTML={{ __html: this.props.data.body_rendered }}></div>
      </div>
    )
  }
}

class AnnouncementList extends React.Component {
  render() {
    return (
      <main className='md-col-8 mx-auto p2'>
        <h1 className='mb0'>Noodles keeps getting better.</h1>
        <h2 className='grey-3 mt1 mb3 regular'>Check back here for the latest updates.</h2>
        {this.props.announcements.map(function(announcement) {
           return <AnnouncementItem key={announcement.id} data={announcement} />;
        })}
      </main>
    )
  }
}
