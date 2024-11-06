
const CategoryItem = ({ name, img, badge }) => {
    return (
        <a href="" className="flex a-center">
            {img && <img src={img} alt="" />}
            <h4>{name}</h4>
            <span className="badge-2 flex a-center j-center">{badge}</span>
        </a>
    );
};

export default CategoryItem;