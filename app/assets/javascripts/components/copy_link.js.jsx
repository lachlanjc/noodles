let reactClipboardCounter = 0;

class CopyLink extends React.Component {
  static propTypes: {
    value: React.propTypes.string.isRequired,
    label: React.propTypes.string,
    className: React.propTypes.string
  }

  propsWith(regexp, remove=false) {
    let object = {};

    Object.keys(this.props).forEach(function(key) {
      if (key.search(regexp) !== -1) {
        let objectKey = remove ? key.replace(regexp, '') : key;
        object[objectKey] = this.props[key];
      }
    }, this);

    return object;
  }

  constructor(props) {
    super(props);
    this.id = `__react_clipboard_${reactClipboardCounter++}__`;
  }

  componentWillUnmount() {
    this.clipboard && this.clipboard.destroy();
  }

  componentDidMount() {
    let options = this.propsWith(/^option-/, true);
    this.clipboard = new Clipboard(`#${this.id}`, options);

    let callbacks = this.propsWith(/^on/, true);
    Object.keys(callbacks).forEach(function(callback) {
      this.clipboard.on(callback.toLowerCase(), this.props['on' + callback]);
    }, this);
  }

  render() {
    return (
      <div className={`flex f5 ${this.props.className}`}>
        <input value={this.props.value} className='text-input dib' readOnly />
        <button id={this.id} type='button' className='btn bg-green btn-sm mls'
                data-clipboard-text={this.props.value}
                {...this.propsWith(/^data-/)} {...this.propsWith(/^button-/, true)}>
          {this.props.label || 'Copy'}
        </button>
      </div>
    )
  }
}
