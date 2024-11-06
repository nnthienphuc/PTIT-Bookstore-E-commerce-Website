import Badge from "./Badge";
import "./Card.scss";
const Card = ({
    img1,
    img2,
    leftBadge,
    leftBadgeColor,
    rightBadge,
    rightBadgeColor,
    title,
    category,
    provier,
    oldPrice,
    newPrice,
    rating,
}) => {
    return (
        <div className="col-xl-1-5 col-lg-4 col-md-6 col-sm-6 col-xs-12" >
            <div className="card ">
                {leftBadge && (
                    <Badge
                        isLeft
                        content={leftBadge}
                        style={{ background: leftBadgeColor }}
                    />
                )}
                {rightBadge && (
                    <Badge
                        content={rightBadge}
                        style={{ background: rightBadgeColor }}
                    />
                )}
                <div className="card-image">
                    <img className="card-img1" src={img1} alt="" />
                    <img className="card-img2" src={img2} alt="" />
                    <div className="card-image-actions flex">
                        <div className="icon quick-view">
                            <i className="fa-regular fa-eye"></i>
                            <span>Quick view</span>
                        </div>
                        <div className="icon compare">
                            <i className="fa-solid fa-code-compare"></i>
                            <span>Compare</span>
                        </div>
                        <div className="icon wishlist">
                            <i className="fa-regular fa-heart"></i>
                            <span>Wishlist</span>
                        </div>
                    </div>
                </div>
                <div className="card-info">
                    <a className="cate" href="">
                        {category}
                    </a>
                    <h2>
                        <a className="title" href="">
                            {title}
                        </a>
                    </h2>
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
                    <div className="provier">
                        By <span>{provier}</span>
                    </div>
                    <div className="flex j-between a-center">
                        <div className="price ">
                            <span className=" new-price ">{newPrice}</span>
                            <span className=" old-price">{oldPrice}</span>
                        </div>
                        <button>
                            <i className="fa-solid fa-cart-plus"></i> Add
                        </button>
                    </div>
                </div>
            </div>
        </div>

    );
};

export default Card;
