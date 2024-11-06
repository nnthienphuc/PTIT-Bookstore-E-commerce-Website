import Benifit from "./Benifit"
const benifit = [
    {
        name: "Best prices & offers",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/icon-1.png",
        details: "Orders $50 or more",
    },
    {
        name: "Free delivery",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/icon-2.png",
        details: "24/7 amazing services",
    },
    {
        name: "Great daily deal",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/icon-3.png",
        details: "When you sign up",
    },
    {
        name: "Wide assortment",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/icon-4.png",
        details: "Mega Discounts",
    },
    {
        name: "Easy returns",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/icon-5.png",
        details: "Within 30 days",
    },


]

const BenifitList = () => {
    return (
        <div className="benifit-list ">
            <div className="ul flex a-center row" >
                {benifit.map((val) => (
                    <Benifit key={val.name} img={val.img} name={val.name} details={val.details} />
                ))}
            </div>
        </div>
    )
}
export default BenifitList