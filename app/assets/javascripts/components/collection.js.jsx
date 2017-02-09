
const CollectionPage = ({
  collection,
  edit = false,
  pub = false
}) => {
  const coll = collection
  const { id, shared_id, user_id, name, description, photo, recipes } = coll
  const cx = 'document mw7 pan oh mbl'
  return (
    <main className={_.isEmpty(photo) && cx}>
      <CollectionHeader edit={edit} pub={pub} coll={coll} />
      {!_.isEmpty(recipes) ?
        <RecipeList
          recipesCore={recipes}
          pub={pub}
          className={!_.isEmpty(photo) && cx}
        />
      :
        <CollectionBlankSlate pub={pub} />
      }
    </main>
  )
}

CollectionPage.propTypes = {
  collection: React.PropTypes.object.isRequired,
  edit: React.PropTypes.bool,
  pub: React.PropTypes.bool
}

const CollectionBlankSlate = ({ pub = true }) =>
  <BlankSlate className='measure bg-white'>
    <h3 className='mvn'>No recipes in this collection yet.</h3>
    {!pub &&
      <div>
        <p className='mvm'>
          Add a recipe from the "Details" section on a recipe page.
        </p>
        <Button
          href='/recipes'
          color='blue'
          children='Add some recipes'
        />
      </div>
    }
  </BlankSlate>

CollectionBlankSlate.propTypes = {
  pub: React.PropTypes.bool
}
