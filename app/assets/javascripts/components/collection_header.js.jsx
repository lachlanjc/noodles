class CollectionHeader extends React.Component {
  componentDidMount () {
    totalModalize()
  }

  render () {
    const { coll, edit, pub } = this.props
    const { name, description, publisher, photo } = coll

    let cx = {
      root: [ 'w-100 bx flex fac' ],
      actions: [ 'caps f4 dn-p mts c--inherit' ]
    }
    let sx = {}
    if (!_.isEmpty(coll.photo)) {
      cx.root.push('image-header white relative inline-with-nav pvl bg-cover bg-center bg-no-repeat')
      sx.backgroundImage = `url('${photo}')`
      cx.actions.push('db mtm mbn')
    } else {
      cx.root.push('tc grey-2 pvl border-bottom')
    }

    return (
      <header className={N.cxs(cx.root)} style={sx}>
        <main className='w-100 w-two-thirds-m mx-auto pam mw7'>
          <h1 className='coll__name c--inherit mvn f0'>
            {_.isEmpty(coll.name) ? 'Loading…' : coll.name}
          </h1>
          {!_.isEmpty(coll.description) &&
            <p className='coll__desc c--inherit f3 mvn'>{coll.description}</p>
          }
          {pub &&
            <p className='coll__desc c--inherit mvs'>Published by {coll.publisher}</p>
          }
          <CollectionHeaderActions
            className={N.cxs(cx.actions)}
            edit={edit}
          />
        </main>
      </header>
    )
  }
}

const CollectionHeaderActions = ({ className, edit }) => (
  <section className={className}>
    {edit &&
      <a
        name='edit'
        href='#edit'
        className='link-reset'
        data-behavior='modal_trigger'
        children='Edit · '
      />
    }
    <a
      name='share'
      href='#share'
      className='link-reset'
      data-behavior='modal_trigger'
      children='Share'
    />
  </section>
)
