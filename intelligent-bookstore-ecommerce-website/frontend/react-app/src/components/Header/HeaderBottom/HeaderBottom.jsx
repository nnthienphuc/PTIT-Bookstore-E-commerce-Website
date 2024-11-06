import "./HeaderBottom.scss"
import icon from "../../../assets/images/Icon.png"
import List from "./List"
import DropdownSection from "./DropdownSection"
import CategoryList from "../../Categories/CategoryList"
import { useRef } from "react"
const HeaderBottom = () => {
    const categoryRef = useRef();
    const iconRef = useRef();

    const handleClick = () => {
        const opacity = categoryRef.current.style.opacity

        if (opacity == 0 || !opacity) {
            categoryRef.current.style.opacity = 1;
            categoryRef.current.style.visibility = "visible";
            iconRef.current.style.transform = "rotate(180deg)"
        } else {
            categoryRef.current.style.opacity = 0;
            categoryRef.current.style.visibility = "hidden";
            iconRef.current.style.transform = "rotate(0)"
        }
    }

    return (
        <div className="header-bottom">
            <div className="container flex j-between a-center">
                <nav>
                    <button onClick={handleClick} className="btn-Categories">
                        <img src={icon} alt="" />
                        Browse All Categories
                        <i ref={iconRef} className="fa-solid fa-chevron-down"></i>
                    </button>
                    <div ref={categoryRef} className="dropdown-wrapper">
                        <CategoryList />
                    </div>
                    <ul>
                        <li><a href="">
                            <i className="fire fa-solid fa-fire"></i>
                            Hot Deals
                        </a></li>
                        <li className="home none">
                            <a href="">
                                Home
                                <i className="fa-solid fa-chevron-down"></i>
                            </a>
                            <ul className="dropdown">
                                <List list={[
                                    "Home1",
                                    "Home2",
                                    "Home3",
                                    "Home4",
                                    "Home5",
                                    "Home6",
                                    "Home7",
                                    "Home8",
                                    "Home9"
                                ]}
                                />
                            </ul>

                        </li>
                        <li className="none">
                            <a href="">
                                About
                            </a>
                        </li>
                        <li className="none">
                            <a href="">
                                Shop
                                <i className="fa-solid fa-chevron-down"></i>
                            </a>
                            <div className="dropdown flex j-between w-100">
                                <DropdownSection title={"Product Style"} list={[
                                    "Product Style One",
                                    "Product Style Two",
                                    "Product Style Three",
                                    "Product Style Four",
                                    "Product Load More",
                                    "Product Infinite Scrolling",
                                    "Shop Wide",
                                    "Shop With Left Sidebar",
                                    "Shop With Right Sidebar",
                                    "Shop List Left Sidebar",
                                    "Shop List Right Sidebar"
                                ]}
                                />
                                <div className="mid ">
                                    <DropdownSection title={"Product Single Style"} list={[
                                        "Product Single Style One",
                                        "Product Single Style Two",
                                        "Product Single Style Three",
                                        "Product Single Style Four"
                                    ]}
                                    />
                                    <DropdownSection title={"Product Single Features"} list={[
                                        "Product With Deals Date",
                                        "Product With Message Box",
                                        "Product With Video Style One",
                                        "Product With Video Style Two",
                                        "Product With Advertisement",
                                    ]}
                                    />
                                </div>

                                <DropdownSection title={"Product Types"} list={[
                                    "Simple product",
                                    "Grouped product",
                                    "External/Affiliate product",
                                    "Variable product",
                                    "Frequently Bought Together",
                                    "Product With No Sidebar",
                                    "Product With Left Sidebar",
                                ]}
                                />
                                <div className="shop-now">
                                    <div className="title">
                                        <h4>Oganic</h4>
                                        <span>Everyday Fresh &</span>
                                        <span>Clean with Our</span>
                                        <span> Products</span>
                                        <button>
                                            <a href="">Shop now</a>
                                        </button>
                                    </div>
                                </div>
                            </div>

                        </li>
                        <li className="none">
                            <a href="">
                                Mega Menu
                                <i className="fa-solid fa-chevron-down"></i>
                            </a>
                            <div className="dropdown flex j-between w-100">
                                <DropdownSection title={"Products 10% Discount"} list={[
                                    "Canada Dry Ginger Ale – 2 L Bottle",
                                    "Cauliflower Species Brassica the genus",
                                    "Nestle Original Mate Coffee Creamer",
                                    "Onion hybrid varieties genus Allium",
                                    "Seeds of Change Organic Red Rice",
                                ]}
                                />
                                <DropdownSection title={"Products 20% Discount"} list={[
                                    "All Natural Style Chicken Meatballs",
                                    "Angie’s Sweet & Salty Kettle Corn staple",
                                    "Blue Almonds Lightly Salted Vegetables",
                                    "Butter fat and protein churned cream",
                                    "Chobani Complete Vanilla Greek Yogurt",
                                ]}
                                />
                                <DropdownSection title={"Products 30% Discount"} list={[
                                    "Collared Nikky Printed Men Neck T-Shirt",
                                    "Crabs are decapod crustaceans fraorder",
                                    "Encore Seafoods Stuffed the occasional",
                                    "Foster Farms Takeout Crispy Classic",
                                    "Fresh mango smoothies with a Blender",
                                ]}
                                />
                                <div className="shop-now two">
                                    <div className="title">
                                        <span>Everyday Fresh &</span>
                                        <span>Clean with Our</span>
                                        <span> Products</span>
                                        <button>
                                            <a href="">Shop now</a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li className="none">
                            <a href="">
                                Vendors
                                <i className="fa-solid fa-chevron-down"></i>
                            </a>
                            <div className="dropdown">
                                <List list={[
                                    "My Orders",
                                    "Store Details",
                                    "Store Listing",
                                    "Dashboard"
                                ]}
                                />
                            </div>

                        </li>
                        <li className="none">
                            <a href="">
                                Blog
                                <i className="fa-solid fa-chevron-down"></i>
                            </a>
                            <div className="dropdown">
                                <List list={[
                                    "Blog Default",
                                    "Blog Grid",
                                    "Blog List",
                                    "Blog Big",
                                    "Blog Wide",
                                    "Single Blog",
                                ]}
                                />
                            </div>

                        </li>
                        <li className="none">
                            <a href="">
                                Pages
                                <i className="fa-solid fa-chevron-down"></i>
                            </a>
                            <div className="dropdown">
                                <List list={[
                                    "About Us",
                                    "Contact",
                                    "My account",
                                    "Shop Cart",
                                    "Shop Compare",
                                    "Shop Wishlist",
                                    "Checkout",
                                    "Privacy Policy",
                                    "Refund and Returns Policy",
                                ]}
                                />
                            </div>

                        </li>
                        <li className="none">
                            <a href="">
                                Contact
                            </a>
                        </li>
                    </ul>
                </nav>

                <div className="contact-support">
                    <div className="icon">
                        <i className="fa-solid fa-headphones"></i>
                    </div>
                    <div className="contact-info">
                        <a href="">1900888123</a>
                        <span>24/7 Support Center</span>
                    </div>
                </div>
            </div>
        </div>
    )

}

export default HeaderBottom