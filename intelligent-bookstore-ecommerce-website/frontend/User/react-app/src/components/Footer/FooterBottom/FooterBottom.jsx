import "./FooterBottom.scss"
const FooterBottom = () => {
    return (
        <div className="footer-bottom">
            <div className="container flex a-center j-between row">
                <p className="para col-lg-3 col-sm-12-c">
                    © 2022, Nest – WordPress Ecommerce Template All rights reserved
                </p>
                <div className="phone-number flex j-between col-lg-5 col-sm-12-c">
                    <div className="number flex a-center">
                        <i className="fa-solid fa-phone-volume"></i>
                        <div className="phone">
                            <h4><a href="">1900646666</a></h4>
                            <p>Working 8:00 - 22:00</p>
                        </div>
                    </div>
                    <div className="number flex a-center ">
                        <i className="fa-solid fa-phone-volume"></i>
                        <div className="phone">
                            <h4><a href="">1900648888</a></h4>
                            <p>24/7 Support Center</p>
                        </div>
                    </div>
                </div>
                <div className="follow-us col-lg-3 col-sm-12-c ">
                    <div className="social-media flex a-center j-end">
                        <h4>Follow Us</h4>
                        <a href=""><i className="fa-brands fa-facebook-f"></i></a>
                        <a href=""><i className="fa-brands fa-twitter"></i></a>
                        <a href=""><i className="fa-brands fa-skype"></i></a>
                        <a href=""><i className="fa-brands fa-instagram"></i></a>
                    </div>
                    <p>Up to 15% discount on your first subscribe</p>
                </div>
            </div>
        </div >
    )
}
export default FooterBottom