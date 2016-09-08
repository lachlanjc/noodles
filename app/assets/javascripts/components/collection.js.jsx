
class CollectionPage extends React.Component {
  constructor (props) {
    super(props)
    this.state = {
      coll: {}
    }
  }

  componentWillMount () {
    this.fetchData()
  }

  fetchData () {
    const { id, shared_id, pub } = this.props
    const dataPath = pub ? `/c/${shared_id}.json` : `/collections/${id}.json`
    $.getJSON(dataPath, r => {
      this.setState({ coll: r.collection })
    })
  }

  render () {
    const { coll } = this.state
    const { shared_id, edit, pub } = this.props
    const hasPhoto = !_.isEmpty(coll.photo)
    const cx = 'document mw7'
    return (
      <main className={!hasPhoto && cx}>
        {coll ?
          <div>
            <CollectionHeader edit={edit} pub={pub} coll={coll} />
            {!_.isEmpty(coll.recipes) ?
              <RecipeList
                recipesCore={coll.recipes}
                pub={pub}
                className={hasPhoto ? `${cx} mbl` : null}
              />
            :
              <CollectionBlankSlate pub={pub} />
            }
          </div>
        :
          <h3 className='tc grey-3 pvl'>Loading…</h3>
        }
      </main>
    )
  }
}

CollectionPage.propTypes = {
  id: React.PropTypes.number.isRequired,
  shared_id: React.PropTypes.string.isRequired,
  edit: React.PropTypes.bool,
  pub: React.PropTypes.bool
}

const CollectionBlankSlate = ({ pub }) => (
  <BlankSlate>
    <h3 className='man'>No recipes in this collection yet.</h3>
    {!pub &&
      <div className='mts'>
        <p>Add recipes by clicking "Add to Collection" at the bottom of any of your recipes.</p>
        <a href='/recipes' className='btn bg-blue mts'>Find some recipes</a>
      </div>
    }
  </BlankSlate>
)

CollectionBlankSlate.propTypes = {
  pub: React.PropTypes.bool
}


class CollectionHeader extends React.Component {
  componentDidMount () {
    totalModalize()
  }

  render () {
    const { coll, edit, pub } = this.props

    let rootClass = 'col-12 bx flex fac'
    let rootStyle = {}
    let actionsClass = 'caps f4 dn-p mts'
    if (!_.isEmpty(coll.photo)) {
      rootClass += ' image-header relative inline-with-nav pvl bg-cover bg-center bg-no-repeat'
      rootStyle.backgroundImage = `url(${coll.photo_url})`
      actionsClass += ' mbm db white'
    } else {
      rootClass += ' tc grey-2 pvm'
    }

    const { name, description, publisher, photo } = coll

    return (
      <header className={rootClass} style={{ backgroundImage: `url(${coll.photo})` }}>
        <main className='sm-col-12 md-col-8 mx-auto phm mw7'>
          <h1 className='coll__name man f0' children={coll.name} />
          {!_.isEmpty(coll.description) &&
            <p className='coll__desc f3 mvn'>{coll.description}</p>
          }
          {pub &&
            <p className='coll__desc mvs'>Published by {coll.publisher}</p>
          }
          <CollectionHeaderActions className={actionsClass} edit={edit} />
        </main>
      </header>
    )
  }
}

const CollectionHeaderActions = ({ className, edit }) => (
  <section className={className}>
    {edit &&
      <a
        name='editCollection'
        href='#editCollection'
        className='link-reset'
        data-behavior='modal_trigger'
        children='Edit · '
      />
    }
    <a
      name='shareCollection'
      href='#shareCollection'
      className='link-reset'
      data-behavior='modal_trigger'
      children='Share'
    />
  </section>
)
