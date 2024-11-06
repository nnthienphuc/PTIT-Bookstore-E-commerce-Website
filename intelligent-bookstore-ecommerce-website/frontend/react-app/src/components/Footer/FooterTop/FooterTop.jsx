import "./FooterTop.scss"
import logo from "../../../assets/images/logo.png"
import FooterList from "./FooterList"
const FooterTop = () => {
    return (
        <div className="footer-top">
            <div className="container row flex ">
                <div className="infomation col-xl-1-5 col-md-4 col-xs-12">
                    <img src={logo} alt="" />
                    <p className="para">
                         Trang web phục vụ học tập của sinh viên
                    </p>
                    <div className="contact">
                        <p>
                            <i className="fa-solid fa-location-dot"></i>
                            97 Man Thiện, P.Hiệp Phú, Q.9, TP.Thủ Đức
                            <span>  1 Nguyễn Đình Chiểu, P.Đa Kao, Q.1, HCM</span>
                        </p>
                        <p>
                            <i className="fa-solid fa-headphones"></i>
                            Call Us
                            <a href="">(+91)-540-025-124553</a>
                        </p>
                        <p>
                            <i className="fa-regular fa-envelope"></i>
                            Email
                            <a href="">sale@Nest.com</a>
                        </p>
                        <p>
                            <i className="fa-regular fa-clock"></i>
                            Hours 10:00 - 18:00, Mon - Sat
                        </p>
                    </div>
                </div>
                <div className=" col-xl-2-b col-md-4 col-xs-12">

                    <FooterList title={"Company"} list={[
                        "About Us",
                        "Delivery Information",
                        "Privacy Policy",
                        "Terms & Conditions",
                        "Contact Us",
                        "Support Center",
                        "Careers",
                    ]} />
                </div>
                <div className=" col-xl-2-b col-md-4 col-xs-12">

                    <FooterList title={"Account"} list={[
                        "Sign In",
                        "View Cart",
                        "My Wishlist",
                        "Track My Order",
                        "Help Ticket",
                        "Shipping Details",
                        "Compare products",
                    ]} />
                </div>
                <div className=" col-xl-2-b col-md-4 col-xs-12">

                    <FooterList title={"Corporate"} list={[
                        "Become a Vendor",
                        "Affiliate Program",
                        "Farm Business",
                        "Farm Careers",
                        "Our Suppliers",
                        "Accessibility",
                        "Promotions",
                    ]} />
                </div>
                <div className=" col-xl-2-b col-md-4 col-xs-12">

                    <FooterList title={"Popular"} list={[
                        "Milk & Flavoured Milk",
                        "Butter and Margarine",
                        "Eggs Substitutes",
                        "Marmalades",
                        "Sour Cream and Dips",
                        "Tea & Kombucha",
                        "Cheese",
                    ]} />
                </div>
                <div className="instal-app col-xl-3 col-md-4 col-xs-12">
                    <h4>Instal App</h4>
                    <p>From App Store or Google Play</p>
                    <div className="link-app flex a-center mb-39">
                        <a href="">
                            <img src="https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/google-play.jpg" alt="" />
                        </a>
                        <a href="">
                            <img src="https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/app-store.jpg" alt="" />
                        </a>
                    </div>
                    <p className="mb-25">Secured Payment Gateways</p>
                    <div className="link-app">
                        <a href="">
                            <img className="bigger" src="https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/payment-method.png" alt="" />
                        </a>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default FooterTop