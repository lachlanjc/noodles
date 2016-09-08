
const CollectionList = ({ collections }) => (
  <main className={`md-col-9 tc ${_.isEmpty(collections) ? 'document' : 'mx-auto pam'}`}>
    <h1 className='tc mtn mbm'>Collections</h1>
    {_.isEmpty(collections) ?
      <CollectionListBlankSlate />
    :
      _.map(collections, coll => {
        return <CollectionListItem coll={coll} key={'coll-' + coll.id} />
      })
    }
  </main>
)

CollectionList.propTypes = {
  collections: React.PropTypes.array.isRequired
}

const CollectionListBlankSlate = () => (
  <BlankSlate width={12} margin='mvs'>
    <h3 className='mtn mbm'>You don't have any collections yet.</h3>
    <p>Collections help you organize your recipes.</p>
    <p className='mbn'>You can use them for categories, such as salads or pastas, or recipes that might be good for a summer dinner party.</p>
    <a href='#newCollection' className='btn bg-green mtm' data-behavior='modal_trigger'>Create your first collection</a>
  </BlankSlate>
)
