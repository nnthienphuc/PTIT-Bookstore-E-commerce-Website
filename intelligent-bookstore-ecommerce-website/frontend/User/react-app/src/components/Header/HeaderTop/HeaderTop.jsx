import "./HeaderTop.scss"
const HeaderTop = () => {
    return (
        <div className="header-top">
            <div className="container">
                <div className="one">
                    <ul>
                        <li className="space"><a href=""> About Us</a></li>
                        <li className="space"><a href="">My Account</a> </li>
                        <li className="space"><a href="">Wishlist</a> </li>
                        <li><a href=""> Order Tracking</a></li>
                    </ul>
                </div>

                <p>Supper Value Deals - Save more with coupons</p>

                <div className="three">
                    <ul>
                        <li className="phone">Need help? Call Us: <a href="">+1800900122</a></li>
                        <li className="space"><a href="">English</a><i className="fa-solid fa-chevron-down"></i>
                            <ul className="dropdown-language">
                                <li><a href=""><img src="https://themepanthers.com/wp/nest/d2/wp-content/plugins/elementor/assets/images/placeholder.png" alt="" />Francais</a></li>
                                <li><a href=""><img src="https://themepanthers.com/wp/nest/d2/wp-content/plugins/elementor/assets/images/placeholder.png" alt="" />Deutsch</a></li>
                                <li><a href=""><img src="https://themepanthers.com/wp/nest/d2/wp-content/plugins/elementor/assets/images/placeholder.png" alt="" />Pyccknn</a></li>
                            </ul>
                        </li>
                        <li><a href="">INR</a>
                            <i className="fa-solid fa-chevron-down"></i>
                            <ul className="dropdown-language">
                                <li><a href=""><img src="https://themepanthers.com/wp/nest/d2/wp-content/plugins/elementor/assets/images/placeholder.png" alt="" />US</a></li>
                                <li><a href=""><img src="https://themepanthers.com/wp/nest/d2/wp-content/plugins/elementor/assets/images/placeholder.png" alt="" />ME</a></li>
                                <li><a href=""><img src="https://themepanthers.com/wp/nest/d2/wp-content/plugins/elementor/assets/images/placeholder.png" alt="" />EU</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    )
}
export default HeaderTop