
const SubscribeModal = () =>
  <Modal
    title='Subscribe to Noodles'
    id='subscribe'
    scrollable
    style={{ width: '36rem', maxWidth: '100%' }}
  >
    <ModalScroller>
      <Subscribe />
      <Spacer y={16} />
      <DonateLink />
    </ModalScroller>
  </Modal>
