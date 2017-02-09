
const Subscribe = () =>
  <section className='serif'>
    <p>
      Right now you can use Noodles completely for free,
      but if you enjoy cooking with it, <strong>please consider buying a subscription</strong>.
    </p>
    <p>
      With a subscription, you’ll be the first to get new features and projects, and you’ll get even faster support.
    </p>
    <p className='sans f3 lh-title mvm' style={{ fontStyle: 'italic' }}>
      Your subscription keeps Noodles running and ad-free. I couldn’t work on this project without subscriptions.
    </p>
    <p>
      Noodles is built by a single, independent developer.
      I’m working on Noodles to make it as great as I can,
      so your contributions will be spent on the services like DigitalOcean that help keep Noodles going.
    </p>
    <SubscribeBtn className='mbm sans' />
    <p>
      It costs $12 for one year.
      <a
        className='grey-3 underline f5 mls'
        href='https://blog.pinboard.in/2011/12/don_t_be_a_free_user/'
        children="(why isn't it free?)"
      />
    </p>
    <p>
      - Lachlan
      <Avatar
        size={28}
        src='https://lachlanjc.me/static/portrait-96.jpg'
        style={{ position: 'relative', left: 8, top: 8 }}
      />
    </p>
  </section>

const SubscribeBtn = (props) =>
  <Button
    primary
    color='green'
    children='Subscribe'
    {...props}
    href='https://plasso.com/s/yIlZwrLZAp'
  />

const DonateLink = (props) =>
  <a
    className='grey-3 underline f5'
    children='Or, send a single donation →'
    {...props}
    href='https://plasso.com/lachlan@getnoodl.es'
  />
