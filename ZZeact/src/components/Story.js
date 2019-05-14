import ZZeact, {Component} from "../../ZZeact/ZZeact"

function call_native (message) {
  window.webkit.messageHandlers.observe.postMessage(message);
}

class Story extends Component {
  constructor(props) {
    super(props);
    this.state = { likes: Math.ceil(Math.random() * 100) };
  }
  like() {
    call_native("likes: " + this.state.likes)
    this.setState({
      likes: this.state.likes + 1
    });
  }
  render() {
    const { name, url } = this.props;
    const { likes } = this.state;
    const likesElement = <span />;
    return (
      <li>
        <button onClick={e => this.like()}>{likes}<b>❤️</b></button>
        <a href={url}>{name}</a>
      </li>
    );
  }
}

export default Story;