import "./Banner_2.scss"

const Banner_2 = () => {
    return (
        <div className="banner-wrapper row flex a-center j-between">
            <div className="col-lg-4 col-md-4 col-xs-12 col-sm-12">
                <div className="banner ">
                    <span>Everyday Fresh &
                        <br />
                        Clean with Our
                        <br />
                        Products</span>
                    <button>
                        <a href="">Shop now
                            <i className="fa-solid fa-arrow-right"></i></a>

                    </button>
                </div>
            </div>
            <div className="col-lg-4 col-md-4 col-xs-12 col-sm-12">
                <div className="banner two ">
                    <span>Make your Breakfast
                        <br />
                        Healthy and Easy</span>
                    <button>
                        <a href="">Shop now
                            <i className="fa-solid fa-arrow-right"></i></a>

                    </button>
                </div>
            </div>
            <div className="col-lg-4 col-md-4 col-xs-12 col-sm-12">
                <div className="banner three">
                    <span>The best Organic
                        <br />
                        Products Online</span>
                    <button>
                        <a href="">Shop now
                            <i className="fa-solid fa-arrow-right"></i></a>

                    </button>
                </div>
            </div>
        </div>
    )
}
export default Banner_2