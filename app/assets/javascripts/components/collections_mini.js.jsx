
const CollectionsMini = ({
  collections,
  hidden = false
}) =>
  <div className={hidden ? 'dn' : 'dn db-ns mtl'}>
    <h2 className='f3 pvs border-bottom mtn mbs'>
      <a href='/collections' className='blue'>Collections</a>
    </h2>
    <ul className='list-reset'>
      {_.map(collections, coll => (
        <CollectionsMiniItem
          name={coll.name}
          path={coll.path}
          key={coll.path}
        />
      ))}
    </ul>
    {_.isEmpty(collections) &&
      <p className='grey-3'>
        No collections yet –
        {' '}
        <a href='/collections?new_collection=true' className='blue'>create your first!</a>
      </p>
    }
  </div>

CollectionsMini.propTypes = {
  collections: React.PropTypes.array.isRequired,
  hidden: React.PropTypes.bool
}

CollectionsMiniItem = ({
  name,
  path
}) =>
  <li className='mts'>
    <a
      className='blue'
      href={path}
      children={name}
    />
  </li>

CollectionsMiniItem.propTypes = {
  name: React.PropTypes.string.isRequired,
  path: React.PropTypes.string.isRequired
}
