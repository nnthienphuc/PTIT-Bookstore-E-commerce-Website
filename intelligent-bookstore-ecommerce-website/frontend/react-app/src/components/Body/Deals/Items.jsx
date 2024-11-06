import "./Items.scss"
const Items = ({ img, title, provier, oldPrice, newPrice }) => {
    return (
        <div className="col-lg-3 col-md-6 col-xs-12 col-b">
            <div className="deal-list-item">
                <img src={img} alt="" />
                <div className="deal-content">
                    <h3>
                        <a className="title" href="">{title}</a>
                    </h3>
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
    )
}

export default Items