
const Button = ({
  is,
  href,
  serif,
  color = 'blue',
  primary,
  sm,
  className,
  ...props
}) => {
  const Tag = is || (_.isEmpty(href) ? 'button' : 'a')
  const cx = [
    'btn',
    sm && 'btn-sm',
    primary && 'btn--primary',
    color && `bg-${color}`,
    serif && 'serif',
    className
  ]
  return (
    <Tag
      {...props}
      href={href}
      className={N.cxs(cx)}
    />
  )
}

Button.propTypes = {
  is: React.PropTypes.string,
  href: React.PropTypes.string,
  serif: React.PropTypes.bool,
  color: React.PropTypes.oneOf(['orange', 'blue', 'green', 'purple', 'red', 'grey-3', 'grey-2']),
  primary: React.PropTypes.bool,
  sm: React.PropTypes.bool,
  className: React.PropTypes.string
}
