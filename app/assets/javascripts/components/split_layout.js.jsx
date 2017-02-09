
const SplitLayout = ({
  heading,
  headingClassName,
  sidebar,
  content,
  contentClassName,
  className,
  ...props
}) => {
  let cx = {}
  cx.root = [
    'flex-md',
    className || 'pam phl-ns'
  ].join(' ')
  cx.sidebar = 'md-col-6 lg-col-4 measure--narrow-ns mbl tc tl-ns'
  cx.heading = [
    'sans orange',
    headingClassName
  ].join(' ')
  cx.content = [
    'mx-auto',
    contentClassName
  ].join(' ')
  return (
    <main
      {...props}
      style={{
        boxSizing: 'border-box',
        alignItems: 'flex-start',
        width: '100%'
      }}
      className={cx.root}
    >
      <aside className={cx.sidebar}>
        <SuperHeader
          className={cx.heading}
          children={heading}
        />
        {sidebar}
      </aside>
      <Spacer x={48} className='dn dib-ns' />
      {content}
    </main>
  )
}

SplitLayout.propTypes = {
  heading: React.PropTypes.string.isRequired,
  headingClassName: React.PropTypes.string,
  sidebar: React.PropTypes.element,
  content: React.PropTypes.element.isRequired,
  contentClassName: React.PropTypes.string,
  className: React.PropTypes.string
}
