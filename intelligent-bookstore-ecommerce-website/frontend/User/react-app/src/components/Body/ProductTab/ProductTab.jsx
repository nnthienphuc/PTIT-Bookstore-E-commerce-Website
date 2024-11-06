import CategoryList from "../Category/CategoryList"
import "./ProductTab.scss"
const ProductTab = () => {
    return (
        <div className="product-tab">
            <div className="tags">
                <h2>Category</h2>
                <CategoryList />
            </div>
            <div className="tags">
                <h2>Product Tags</h2>
                <div className="product-tag flex a-center">
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Brown
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Coffes
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Cream
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Hodo Foods
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Meats
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Organic
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Snack
                    </a>
                    <a href="">
                        <i className="fa-solid fa-xmark"></i>
                        Vegetables
                    </a>
                </div>
            </div>
            <div className="banner-2">
                <span>Organic</span>
                <h4>
                    Save 17%
                    <br />
                    on  <span className="text">Oganic</span>
                    <br />
                    Juice
                </h4>
            </div>
        </div>
    )
}

export default ProductTab