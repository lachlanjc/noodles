
const Flags = ({
  subscribe = true,
  ...props
}) =>
  <div className='w-100 mlm-ns tc tl-ns' {...props}>
    <HelpFlag />
    {subscribe && <SubscribeFlag />}
  </div>

const Flag = ({
  modal,
  label,
  ...props
}) => {
  const sx = {
    borderRadius: '6px 6px 0 0',
    color: '#fff',
    display: 'inline-block',
    fontWeight: 600,
    textAlign: 'center'
  }
  return (
    <ModalLink
      name={modal}
      className='f4 lh bg-blue mlm pvs phm'
      style={sx}
      children={label}
    />
  )
}

Flag.propTypes = {
  modal: React.PropTypes.string.isRequired,
  label: React.PropTypes.string.isRequired,
}

const HelpFlag = () =>
  <Flag
    modal='help'
    label='Help & feedback'
  />

const SubscribeFlag = () =>
  <Flag
    modal='subscribe'
    label='Subscribe'
  />
