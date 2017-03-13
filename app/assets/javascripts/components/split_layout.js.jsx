
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
  cx.root = N.cxs([
    'flex-md',
    className || 'pam phl-ns'
  ])
  cx.sidebar = 'w-50-m w-third-l measure--narrow-ns mbl tc tl-ns'
  cx.heading = N.cxs([
    'sans orange',
    headingClassName
  ])
  cx.content = N.cxs([
    'mx-auto',
    contentClassName
  ])
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
