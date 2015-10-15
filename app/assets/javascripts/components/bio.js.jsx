class Bio extends React.Component {
  render() {
    const lachlan = {
      name: "Lachlan Campbell",
      description: "Creator of Noodles and high schooler. Previous intern at Highrise.",
      username: "lachlanjc"
    }
    const taran = {
      name: "Taran Samarth",
      description: "Co-founder of Noodles. Hacker, writer, and football geek.",
      username: "tarans22"
    }
    let user = lachlan;
    if (this.props.person == "tns") {
      user = taran;
    }
    return (
      <div className="pvm">
        <h3 className="man">{user.name}</h3>
        <p className="man">{user.description}</p>
        <a href={"https://twitter.com/" + user.username} className="f5 white b dib phs rounded bg-orange">
          @{user.username}
        </a>
      </div>
    )
  }
}
