import "./SideMenuAction.scss"
const SideMenuAction = (props) => {
    return (
        <div className="sidemenu-action" style={props.style}>
            <button>
                <i className="fa-regular fa-file-lines"></i>
                <span className="infor">Docs</span>
            </button>
            <button>
                <i className="fa-solid fa-gear"></i>
                <span className="infor">Support</span>
            </button>
        </div>
    )
}
export default SideMenuAction
