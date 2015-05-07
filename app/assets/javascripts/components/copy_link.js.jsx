var CopyLink = React.createClass({
  getInitialState: function() {
    return { label: "Copy" }
  },

  render: function() {
    return (
      <div className="h5">
        <input ref="text"
            type="text"
            className="text-input"
            style={{display: "inline-block"}}
            value={this.props.url}
            onChange={function() {}} />
          <button ref="copy" className="btn btn-green ml2" type="button">{this.state.label}</button>
      </div>
    );
  },

  componentDidMount: function() {
    var self = this;
    var client = new ZeroClipboard(this.refs.copy.getDOMNode());
    client.on("ready", function(event) {
      client.on("copy", function(event) {
        event.clipboardData.setData("text/plain", self.props.url)
      });

      client.on("aftercopy", function(e) {
        self.setState({label: "Copied!"});
        setTimeout(function() {
          self.setState({label: "Copy"})
        }, 1000);
      });
    });
  }
});
