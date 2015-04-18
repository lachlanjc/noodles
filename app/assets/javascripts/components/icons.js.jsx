var Icon = React.createClass({
  getDefaultProps: function() {
    return {size: "24px"};
  },
  render: function() {
    return (
      <svg xmlns="http://www.w3.org/2000/svg" width={this.props.size} height={this.props.size} viewBox="0 0 24 24" className={this.props.classes} onClick={this.props.onClick}>
        <path d={this.props.path} />
      </svg>
    );
  }
});

var IconAdd = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z" />;
  }
});

var IconClose = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z" />;
  }
});

var IconCancel = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M12 2C6.47 2 2 6.47 2 12s4.47 10 10 10 10-4.47 10-10S17.53 2 12 2zm5 13.59L15.59 17 12 13.41 8.41 17 7 15.59 10.59 12 7 8.41 8.41 7 12 10.59 15.59 7 17 8.41 13.41 12 17 15.59z" />;
  }
});

var IconCheck = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z" />;
  }
});

var IconEdit = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z" />;
  }
});

var IconList = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M14 10H2v2h12v-2zm0-4H2v2h12V6zm4 8v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zM2 16h8v-2H2v2z" />;
  }
});

var IconArrowRight = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M8.59 16.34l4.58-4.59-4.58-4.59L10 5.75l6 6-6 6z" />;
  }
});


var IconInfo = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M11 17h2v-6h-2v6zm1-15C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zM11 9h2V7h-2v2z" />;
  }
});

var IconFavorite = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />;
  }
});

var IconFavoriteOutline = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M22 9.24l-7.19-.62L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21 12 17.27 18.18 21l-1.63-7.03L22 9.24zM12 15.4l-3.76 2.27 1-4.28-3.32-2.88 4.38-.38L12 6.1l1.71 4.04 4.38.38-3.32 2.88 1 4.28L12 15.4z" />;
  }
});

var IconLocked = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm3.1-9H8.9V6c0-1.71 1.39-3.1 3.1-3.1 1.71 0 3.1 1.39 3.1 3.1v2z" />;
  }
});

var IconPhoto = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z" />;
  }
});

var IconRandom = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M7 2v11h3v9l7-12h-4l4-8z" />;
  }
});

var IconSearch = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z" />;
  }
});

var IconShare = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M18 16.08c-.76 0-1.44.3-1.96.77L8.91 12.7c.05-.23.09-.46.09-.7s-.04-.47-.09-.7l7.05-4.11c.54.5 1.25.81 2.04.81 1.66 0 3-1.34 3-3s-1.34-3-3-3-3 1.34-3 3c0 .24.04.47.09.7L8.04 9.81C7.5 9.31 6.79 9 6 9c-1.66 0-3 1.34-3 3s1.34 3 3 3c.79 0 1.5-.31 2.04-.81l7.12 4.16c-.05.21-.08.43-.08.65 0 1.61 1.31 2.92 2.92 2.92 1.61 0 2.92-1.31 2.92-2.92s-1.31-2.92-2.92-2.92z" />;
  }
});

var IconNotes = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M21 0H3C1.35 0 0 1.35 0 3v18c0 1.65 1.35 3 3 3h18c1.65 0 3-1.35 3-3V3c0-1.65-1.35-3-3-3zm-1 13H4v-3h16v3zm-6 6H4v-3h10v3zm6-12H4V4h16v3z" />;
  }
});

var IconWeb = React.createClass({
  render: function() {
    return <Icon size={this.props.size} classes={this.props.classes} onClick={this.props.onClick} path="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-1 17.93c-3.95-.49-7-3.85-7-7.93 0-.62.08-1.21.21-1.79L9 15v1c0 1.1.9 2 2 2v1.93zm6.9-2.54c-.26-.81-1-1.39-1.9-1.39h-1v-3c0-.55-.45-1-1-1H8v-2h2c.55 0 1-.45 1-1V7h2c1.1 0 2-.9 2-2v-.41c2.93 1.19 5 4.06 5 7.41 0 2.08-.8 3.97-2.1 5.39z" />;
  }
});
