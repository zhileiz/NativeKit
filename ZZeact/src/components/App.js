import Story from "./Story"
import ZZeact, {Component} from "../../ZZeact/ZZeact"

function call_native (message) {
  window.webkit.messageHandlers.observe.postMessage(message);
}

class App extends Component {

  closeApp() {
    call_native("close")
  }
  render() {
    return (
      <div>
        <h1>Didact Stories</h1>
        <ul>
          {this.props.stories.map(story => {
            return <Story name={story.name} url={story.url} />;
          })}
        </ul>
        <button onClick={e => this.closeApp()}>Close</button>
      </div>
    );
  }
}

export default App;