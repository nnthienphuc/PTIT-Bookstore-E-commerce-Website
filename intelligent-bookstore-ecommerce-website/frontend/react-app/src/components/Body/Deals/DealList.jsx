import Items from "./Items"
const deals = [
    {
        id: 1,
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/03/banner-5-min.png",
        title: "Organic Cage Grade A Large Eggs",
        provier: "Hambger Hel",
        oldPrice: "$24.00",
        newPrice: "$21.00"
    },
    {
        id: 2,
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/03/banner-6-min.png",
        title: "Naturally Flavored Cinnamon Vanilla",
        provier: "Hambger Hel",
        oldPrice: "$55.00",
        newPrice: "$51.00"
    },
    {
        id: 3,
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/03/banner-7-min.png",
        title: "Seeds of Change Organic Watermelon",
        provier: "Hambger Hel",
        oldPrice: "$66.00",
        newPrice: "$61.50"
    },
    {
        id: 4,
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/03/banner-8-min.png",
        title: "Nestle Coffee Mate Coffee Creamer",
        provier: "Totino's Pizza",
        oldPrice: "$53.80",
        newPrice: "$52.80"
    },
]

const DealList = () => {
    return (
        <div className="deals-list row flex a-center j-center">
            {deals.map((val) => (
                <Items
                    key={val.id}
                    img={val.img}
                    id={val.id}
                    title={val.title}
                    provier={val.provier}
                    oldPrice={val.oldPrice}
                    newPrice={val.newPrice}
                />
            ))}
        </div>
    );
};
export default DealList