import Input from "../Input/Input"
import "./Banner.scss"
import Slider from "react-slick"
const Banner = () => {
    const settings = {
        dots: true,
        infinite: true,
        speed: 500,
        slidesToShow: 8,
        slidesToScroll: 8,
        autoplay: true,
        autoplaySpeed: 3000,
        fade: true,
    };
    return (

        <div className="banner">
            <Slider {...settings}>
                <div className="banner-item">
                    <div className="container flex a-center">
                        <h1>
                            Don’t miss amazing
                            <br />
                            grocery deals
                        </h1>
                        <p>Sign up for the daily newsletter</p>
                        <Input />
                    </div>
                </div>
                <div className="banner-item banner-item-2">
                    <div className="container flex a-center">
                        <h1>
                            Fresh Vegetables
                            <br />
                            Big discount
                        </h1>
                        <p>Sign up for the daily newsletter</p>
                        <Input />
                    </div>
                </div>
            </Slider>

        </div>
    )
}
export default Banner