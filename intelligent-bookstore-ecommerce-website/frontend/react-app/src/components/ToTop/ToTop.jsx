
import "./ToTop.scss"
const ToTop = (props) => {
    const handelClick = () => {
        window.scrollTo({ top: 0, left: 0, behavior: 'smooth' })
    }

    return (
        <button onClick={handelClick} className="btn-to-top flex a-center j-center" style={props.style}  >
            <i className="fa-solid fa-arrow-up-long"></i>
        </button>
    )
}
export default ToTop