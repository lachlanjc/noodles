
const Modal = ({
  id,
  children,
  className,
  title,
  scrollable = false,
  ...props
}) =>
  <section
    {...props}
    className={N.cxs([ 'modal', scrollable && 'modal--scrollable', className ])}
    role='dialog'
    id={id}
  >
    <header className='mbm border-bottom'>
      <action
        role='button'
        className='db fr pointer'
        data-behavior='modal_close'
      >
        <Icon icon='close' className='fill-grey-3' />
      </action>
      <h2 className='tl mtn mbs' children={title} />
    </header>
    {children}
  </section>

Modal.propTypes = {
  id: React.PropTypes.string.isRequired,
  className: React.PropTypes.string,
  children: React.PropTypes.node.isRequired,
  title: React.PropTypes.string.isRequired,
  scrollable: React.PropTypes.bool
}

const ModalScroller = ({ className, ...props }) =>
  <article {...props} className={N.cxs([ 'modal__scroller', className ])} />
