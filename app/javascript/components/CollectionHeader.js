import React from 'react'
import PropTypes from 'prop-types'

const CollectionHeader = ({ coll, edit, pub }) => (
  <header
    className="w-100 bx flex fac db mtm mbn image-header white relative inline-with-nav pvl bg-cover bg-center bg-no-repeat"
    style={{
      backgroundImage: `url('${coll.photo}')`
    }}
  >
    <main className="w-100 w-two-thirds-m mx-auto pam mw7">
      <h1 className="coll__name c--inherit mvn f0">
        {_.isEmpty(coll.name) ? 'Loading…' : coll.name}
      </h1>
      {!_.isEmpty(coll.description) &&
        <p className="coll__desc c--inherit f3 mvn">{coll.description}</p>}
      {pub &&
        <p className="coll__desc c--inherit mvs">
          Published by {coll.publisher}
        </p>}
      <CollectionHeaderActions
        className="caps f4 dn-p mts c--inherit"
        edit={edit}
      />
    </main>
  </header>
)
export default CollectionHeader
CollectionHeader.propTypes = {
  coll: PropTypes.object.isRequired,
  edit: PropTypes.bool,
  pub: PropTypes.bool
}
const CollectionHeaderActions = ({ className, edit }) => (
  <section className={className}>
    {edit &&
      <a
        name="edit"
        href="#edit"
        className="link-reset"
        data-behavior="modal_trigger"
        children="Edit · "
      />}
    <a
      name="share"
      href="#share"
      className="link-reset"
      data-behavior="modal_trigger"
      children="Share"
    />
  </section>
)
