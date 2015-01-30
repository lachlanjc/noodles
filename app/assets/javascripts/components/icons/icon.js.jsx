var Icon = React.createClass({
  render: function() {
    var classes = "icon " + this.props.classes
    return <div className={classes}>{this.props.children}</div>;
  }
});
