
const HelpModal = ({ email }) =>
  <Modal
    title='Help & feedback'
    id='help'
    style={{ width: '36rem', maxWidth: '100%' }}
    children={<HelpContent email={email} />}
  />

const HelpIntro = () =>
  <div className='flex fac mvm'>
    <Avatar src='https://lachlanjc.me/static/portrait-96.jpg' />
    <div
      className='flex-auto mlm pvs phm rounded content sans f5 lh-copy'
      style={{ backgroundColor: '#ecf9fd' }}
    >
      Hey! I'm <a href='https://lachlanjc.me/'>Lachlan</a>, the creator of Noodles. If you need help or have questions/feedback, please let me know – I'm here to help.
    </div>
  </div>

const HelpResponse = ({ children }) =>
  <div className='flex fac mtm'>
    <Avatar src='https://lachlanjc.me/static/missing_avatar-96.png' />
    <Spacer x={16} />
    <HelpButtons />
  </div>

const HelpButtons = () =>
  <div className='flex fac fjc'>
    <Button
      href='mailto:lachlan@getnoodl.es'
      color='blue'
      children='Email'
    />
    <Spacer x={16} />
    <Button
      href='http://m.me/getnoodles'
      color='grey-3'
      sm
      children='Messenger'
    />
    <Spacer x={16} />
    <Button
      href='https://twitter.com/noodlesapp'
      color='grey-3'
      sm
      children='Twitter'
    />
  </div>

const HelpContent = ({ email }) =>
  <article>
    <HelpIntro />
    <HelpResponse />
  </article>

/*
const sx = {
  label: {
    boxSizing: 'border-box',
    display: 'inline-block',
    paddingRight: 16,
    textAlign: 'center',
    width: 48
  },
  input: {
    border: 0,
    borderRadius: 0,
    margin: 0,
    paddingLeft: 0,
    height: 32
  },
  cover: {
    position: 'relative',
    top: -2,
    paddingTop: 4,
    borderTop: '1px solid #fff'
  }
}

const HelpForm = ({ email }) => (
  <form
    action='https://formspree.io/lachlan@getnoodl.es'
    method='POST'
    className='flex fac mbm'
  >
    <div className='flex-auto mrm'>
      <label className='label col-12 flex fac man border-bottom'>
        <span style={sx.label}>Email</span>
        <input
          type='email'
          name='email'
          defaultValue={email}
          placeholder='me@icloud.com'
          className='text-input flex-auto bx man mls'
          style={sx.input}
        />
      </label>
      <label className='label col-12 flex fac man'>
        <span style={_.merge(sx.label, sx.cover)}>Body</span>
        <textarea
          id='message'
          name='message'
          rows={1}
          placeholder='How do I…'
          className='text-input flex-auto bx man mls'
          style={sx.input}
        />
      </label>
    </div>
    <Button
      is='input'
      type='submit'
      value='Send'
      color='blue'
      className='man'
    />
  </form>
)
*/
