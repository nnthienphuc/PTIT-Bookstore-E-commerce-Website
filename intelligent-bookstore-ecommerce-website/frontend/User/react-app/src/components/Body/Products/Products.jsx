import "./Products.scss"
import ListCard from "../Card/ListCard"
import DealList from "../Deals/DealList"
const Products = () => {

    return (
        <div className="product-items">
            <ListCard />
            <div className="Deal-of-the-day">
                <div className="action flex j-between">
                    <h2>Deals Of The Day</h2>
                    <a className="all-deals" href="">All Deals
                        <i className="fa-solid fa-chevron-right"></i>
                    </a>
                </div>
                <DealList />
            </div>
        </div>
    )
}
export default Products
