class CopyLink extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      copied: false
    };
  }

  render() {
    const label = this.state.copied ? 'Copied!' : 'Copy';
    return (
      <div className='f5'>
        <input ref='text'
              type='text'
              className='text-input dib'
              value={this.props.url}
              onChange={function() {}} />
          <button ref='copy' className='btn bg-green ml2' type='button'>{label}</button>
      </div>
    )
  }

  componentDidMount() {
    const self = this;
    const client = new ZeroClipboard(this.refs.copy.getDOMNode());
    client.on('ready', function(e) {
      client.on('copy', function(e) {
        e.clipboardData.setData('text/plain', self.props.url)
      });

      client.on('aftercopy', function(e) {
        self.setState({copied: true});
        setTimeout(function() {
          self.setState({copied: false})
        }, 1000);
      });
    });
  }
}
