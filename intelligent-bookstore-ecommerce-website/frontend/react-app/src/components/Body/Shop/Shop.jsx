import ListCard_2 from "../Card_2/ListCard_2"
import CategoryList_2 from "./CategoryList_2"
import "./Shop.scss"
const Shop = () => {
    return (
        <div className="shop-category">
            <div className="action flex a-center">
                <h2>Popular Products</h2>
                <span>
                    <a className="all-deals" href="">All Categories
                        <i className="fa-solid fa-chevron-right"></i>
                    </a>
                </span>
            </div>
            <div className="categories-2">
                <CategoryList_2 />
                <div className="top-categoies">
                    <nav>
                        <ul className="flex a-center j-between">
                            <li>Top Selling</li>
                            <li>Trending Products</li>
                            <li>Recently added</li>
                            <li>Top Rated</li>
                        </ul>
                    </nav>
                    <ListCard_2 />
                </div>
            </div>
        </div>
    )
}
export default Shop