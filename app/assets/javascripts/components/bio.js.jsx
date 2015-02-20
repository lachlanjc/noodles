var BioLachlan = React.createClass({
  render: function() {
    return <div className="bio mt2">
      <div className="bio-photo inline-block float-left">
        <img src="http://d1fmxjrxw87eps.cloudfront.net/me.jpg" className="circle shadow" />
      </div>
      <div className="bio-info inline-block mt2 ml2">
        <h2 className="inline-block m0">Lachlan Campbell</h2>
        <a href="https://twitter.com/lachlanjc" className="badge">@lachlanjc</a>
        <p>Design, hacking, and middle school. Founder of Noodles.</p>
      </div>
    </div>
  }
});

var BioTaran = React.createClass({
  render: function() {
    return <div className="mt2">
      <h2 className="inline-block m0">Taran Samarth</h2>
      <a href="https://twitter.com/tarans22" className="badge">@tarans22</a>
      <p>Co-founder of Noodles. Hacker, writer, and football geek.</p>
    </div>
  }
});
