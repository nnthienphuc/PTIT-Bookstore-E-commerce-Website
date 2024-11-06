
const CategoryItem = ({ name, img, badge }) => {
    return (
        <li className="flex a-center">
            <a href="" className="flex a-center">
                {img && <img src={img} alt="" />}
                <h4>{name}</h4>
                <span className="badge-1">{badge}</span>
            </a>
        </li>
    );
};

export default CategoryItem;