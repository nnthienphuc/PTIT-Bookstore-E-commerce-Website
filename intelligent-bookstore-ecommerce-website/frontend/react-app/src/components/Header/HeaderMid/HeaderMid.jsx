import "./HeaderMid.scss"
import logo from "../../../assets/images/logo.png"
const HeaderMid = () => {
    return (
        <div className="header-mid">
            <div className="container flex a-center j-between">
                <div className="logo">
                    <a href="">
                        <img src={logo} alt="" />
                    </a>
                </div>
                <nav>
                <ul>
                    <li>Giới thiệu</li>
                    <li>Liên hệ</li>
                    <li>Góp ý</li>
                </ul>
                </nav>
                <div className="input-group">
                    <input type="text" placeholder="Search for products..." />
                    <button className="btn-search">Search</button>
                </div>
                <nav>
                    <ul>       
                        <li>
                            <a href=""><i className="fa-solid fa-cart-shopping"></i> Cart</a>
                            <span>0</span>
                        </li>
                        <li><a href=""><i className="fa-regular fa-user"></i> Account</a>
                            <div className="dropdown-account">
                                <li>
                                    <a href="">Login</a>
                                </li>
                            </div>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>

    )
}

export default HeaderMid