import React from 'react'
import PropTypes from 'prop-types'

const Modal = ({
  id,
  children,
  className,
  title,
  scrollable = false,
  ...props
}) => (
  <section
    {...props}
    className={N.cxs(['modal', scrollable && 'modal--scrollable', className])}
    role="dialog"
    id={id}
  >
    <header className="mbm border-bottom">
      <action
        role="button"
        className="db fr pointer"
        data-behavior="modal_close"
      >
        <Icon icon="close" className="fill-grey-3" />
      </action>
      <h2 className="tl mtn mbs" children={title} />
    </header>
    {children}
  </section>
)

Modal.propTypes = {
  id: PropTypes.string.isRequired,
  className: PropTypes.string,
  children: PropTypes.node.isRequired,
  title: PropTypes.string.isRequired,
  scrollable: PropTypes.bool
}

export default Modal

export const ModalScroller = ({ className, ...props }) => (
  <article {...props} className={N.cxs(['modal__scroller', className])} />
)

ModalScroller.propTypes = {
  className: PropTypes.string
}
