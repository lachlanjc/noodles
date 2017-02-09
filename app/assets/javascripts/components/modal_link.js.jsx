
const ModalLink = ({
  name,
  is = 'a',
  ...props
}) => {
  const Tag = is == 'btn' ? Button : is
  return (
    <Tag
      {...props}
      href={`#${name}`}
      data-behavior='modal_trigger'
    />
  )
}

ModalLink.propTypes = {
  name: React.PropTypes.string.isRequired,
  is: React.PropTypes.string
}
