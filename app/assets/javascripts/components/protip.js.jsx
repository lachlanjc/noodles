class ProTip extends React.Component {
  constructor(props) {
    super(props)
  }

  render() {
    const protips = [
      <span>See only your shared recipes by searching <strong>/shared</strong>.</span>,
      <span>Create a new recipe super quickly by searching with its title.</span>,
      <span>Not sure which recipe to cook right now? Click <strong>Random</strong> at the top.</span>
    ];
    const tip = protips[_.random(0,2)];

    return (
      <footer className='tc'>
        <Icon icon='protip' size={24} className='dib fill-grey-4 mrs relative' style={{top: 6}} />
        <strong>ProTip! </strong>
        {tip}
      </footer>
    )
  }
}
