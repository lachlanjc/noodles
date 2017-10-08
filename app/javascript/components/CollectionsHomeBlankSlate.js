import BlankSlate from './BlankSlate'
import ModalLink from './ModalLink'

const CollectionsHomeBlankSlate = () => (
  <BlankSlate className="bg-white tc mvl mx-auto">
    <h2 className="mtn">Let’s make some collections!</h2>
    <p>
      Collections help you organize your recipes into groups{', '}
      <br className="dn db-ns" />
      such as pastas, snacks, or breakfast foods.
    </p>
    <ModalLink
      is="btn"
      primary
      color="green"
      name="new"
      children="Make a collection"
    />
  </BlankSlate>
)
export default CollectionsHomeBlankSlate
