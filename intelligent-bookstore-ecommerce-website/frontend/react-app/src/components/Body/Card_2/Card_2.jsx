import "./Card_2.scss";
const Card_2 = ({
    img,
    title,
    oldPrice,
    newPrice,
    rating,
}) => {
    return (
        <div className="card_2 flex a-center">
            <img src={img} alt="" />
            <div className="card-2-info">
                <h4 className="title">{title}</h4>
                <div className="rating">
                    {[...Array(5)].map((val, index) => {
                        return index <= rating - 1 ? (
                            <i key={index} className="fa-solid fa-star yellow"></i>
                        ) : (
                            <i key={index} className="fa-regular fa-star gray"></i>
                        )
                    })}
                    <span>{rating}</span>
                </div>
                <div className="price ">
                    <span className=" new-price ">{newPrice}</span>
                    <span className=" old-price">{oldPrice}</span>
                </div>
            </div>
        </div>
    );
};
export default Card_2