
const SectionHeader = ({
  level = 1,
  className,
  children,
  ...props
}) => {
  const Tag = `h${level}`
  const cx = ['section-header', className].join(' ')
  return (
    <Tag className={cx} {...props}>
      <span
        className='section-header__name'
        children={children}
      />
    </Tag>
  )
}

SectionHeader.propTypes = {
  level: React.PropTypes.oneOf([1, 2, 3, 4]),
  className: React.PropTypes.string,
  children: React.PropTypes.element
}
