var BioLachlan = React.createClass({
  render: function() {
    return <div className="bio m1-top">
      <div className="bio-photo">
        <img src="http://d1fmxjrxw87eps.cloudfront.net/me.jpg" />
      </div>
      <div className="bio-info ib m1-top">
        <h2 className="ib m0">Lachlan Campbell</h2>
        <a href="https://twitter.com/lachlanjc" className="badge">@lachlanjc</a>
        <p>Design, hacking, and middle school. Founder of Noodles.</p>
      </div>
    </div>
  }
});

var BioTaran = React.createClass({
  render: function() {
    return <div className="m1-top">
      <h2 className="ib m0">Taran Samarth</h2>
      <a href="https://twitter.com/tarans22" className="badge">@tarans22</a>
      <p>Co-founder of Noodles. Hacker, writer, and football geek.</p>
    </div>
  }
});
