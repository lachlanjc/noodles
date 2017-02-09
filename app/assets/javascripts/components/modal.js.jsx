
const Modal = ({
  id,
  title,
  children,
  ...props
}) =>
  <section
    {...props}
    className='modal'
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
  title: React.PropTypes.string.isRequired,
  children: React.PropTypes.node.isRequired
}
