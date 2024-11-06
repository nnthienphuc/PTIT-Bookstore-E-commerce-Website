import List from "./List"
import "./FooterTop.scss"
const FooterList = ({ title, list }) => {
    return (
        <div className="footer-list">
            <h4>{title}</h4>
            <List list={list} />
        </div>
    )
}

export default FooterList