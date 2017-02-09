
const CollectionsHome = ({ collections, ...props }) =>
  <SplitLayout
    heading='Collections'
    sidebar={
      <ModalLink
        is='btn'
        name='new'
        primary
        color='blue'
        children='New collection'
      />
    }
    content={<CollectionList collections={collections} />}
    contentClassName='mw8'
  />

CollectionsHome.propTypes = {
  collections: React.PropTypes.array.isRequired
}
