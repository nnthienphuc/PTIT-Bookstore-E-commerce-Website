
const CategoryItem = ({ name, img, item }) => {
    return (
        <div className="item_2 flex a-center" >
            <a href="" >
                {img && <img src={img} alt="" />}
            </a>
            <h4>
                <a href="">{name}</a>
            </h4>
            <span className="item">{item}</span>
        </div>
    );
};

export default CategoryItem;