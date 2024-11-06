import List from "./List"
import "./HeaderBottom.scss"
const DropdownSection = ({ title, list }) => {
    return (
        <div className="dropdown-section">
            <h4>{title}</h4>
            <List list={list} />
        </div>
    )
}

export default DropdownSection