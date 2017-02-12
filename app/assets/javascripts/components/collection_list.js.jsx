
const CollectionList = ({
  collections,
  ...props
}) =>
  <section className='flex-grid tc'>
    {_.map(collections, coll =>
      <CollectionListItem coll={coll} key={`coll-${coll.id}`} />
    )}
  </section>

CollectionList.propTypes = {
  collections: React.PropTypes.array.isRequired
}
