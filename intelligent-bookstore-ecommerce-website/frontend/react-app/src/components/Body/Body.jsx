import Banner from "./Banner/Banner"
import Products from "./Products/Products"
import ProductTab from "./ProductTab/ProductTab"
import Banner_2 from "./Banner_2/Banner_2"
import Shop from "./Shop/Shop"
import Subcriber from "./Subcriber/Subcriber"
const Body = () => {
    return (
        <div className="body">
             <Banner /> 
            <div className="main-body ">
                <div className="container">
                    <div className="products flex j-between">
                        <Products />
                        <ProductTab />
                    </div>
                    {/* <Banner_2 /> */}
                    {/* <Shop /> */}
                    {/* <Subcriber /> */}
                </div>
            </div>
        </div>
    )
}

export default Body