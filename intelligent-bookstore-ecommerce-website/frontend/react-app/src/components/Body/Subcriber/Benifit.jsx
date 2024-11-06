
const Benifit = ({ name, img, details }) => {
    return (
        <div className="col-xl-1-5 col-lg-4 col-md-6 col-sm-6 col-xs-12">
            <div className=" li flex a-center" >
                {img && <img src={img} alt="" />}
                <div className="benifit-info">
                    <h4>
                        {name}
                    </h4>
                    <p className="details"> {details}</p>
                </div>
            </div>
        </div>
    );
};

export default Benifit;