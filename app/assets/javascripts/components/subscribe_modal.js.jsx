
const SubscribeModal = () =>
  <Modal
    title='Subscribe to Noodles'
    id='subscribe'
    style={{ width: '36rem', maxWidth: '100%' }}
  >
    <Subscribe />
    <Spacer y={16} />
    <DonateLink />
  </Modal>
