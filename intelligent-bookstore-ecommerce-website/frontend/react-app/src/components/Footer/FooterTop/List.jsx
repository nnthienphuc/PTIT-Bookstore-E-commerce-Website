import "./FooterTop.scss"
const List = ({ list }) => {
    return (
        <ul>
            {list.map((item) => (
                <li key={item}>
                    <a href="">{item}</a>
                </li>
            ))}
        </ul>
    )
}

export default List