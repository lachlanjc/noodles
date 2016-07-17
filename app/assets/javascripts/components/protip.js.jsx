
const tips = [
  <span>Create a new recipe super quickly by searching with its title.</span>,
  <span>Not sure which recipe to cook right now? Click <strong>Random</strong> at the top.</span>
]

const ProTip = () => {
  const tip = tips[_.random(0,1)]
  return (
    <footer className='tc'>
      <Icon
        icon='protip'
        className='dib fill-grey-3 mrs relative'
        style={{ top: 6 }}
      />
      <strong
        style={{ marginRight: 8 }}
        children='ProTip!'
      />
      {tip}
    </footer>
  )
}
