import "./Subcriber.scss"
import Input from "../Input/Input"
import banner from "../../../assets/images/banner-9-min.png"
import BenifitList from "./BenifitList"
const Subcriber = () => {
    return (
        <div className="subcriber">
            <div className="subcriber-content">
                <h2>
                    Stay home & get your daily needs from our shop
                </h2>
                <p>Start Your Daily Shopping with <span>Nest Mart</span></p>
                <Input />
                <img className="img" src={banner} alt="" />
            </div>

            <BenifitList />
        </div>
    )
}
export default Subcriber