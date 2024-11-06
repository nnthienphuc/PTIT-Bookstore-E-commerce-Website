import Card_2 from "./Card_2"

const product = [
    {
        id: 1,
        title: "All Natural Style Chicken Meatballs",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-2-1.jpg",
        oldPrice: "$55.80",
        newPrice: "$61.50",
        rating: 2
    },
    {
        id: 2,
        title: "Seeds of Change Organic Watermelon",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/product-20-2-min.jpg",
        oldPrice: "$66.00",
        newPrice: "$52.85",
        rating: 1
    },
    {
        id: 3,
        title: "Seeds of Change Organic Red Rice",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-1-1.jpg",
        oldPrice: "$32.80",
        newPrice: "$28.85",
        rating: 1
    },
    {
        id: 4,
        title: "All Natural Style Chicken Meatballs",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-2-1.jpg",
        oldPrice: "$52.80",
        newPrice: "$48.85",
        rating: 1
    },
    {
        id: 5,
        title: "Angie’s Sweet & Salty Kettle Corn",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-3-1.jpg",
        oldPrice: "$52.80",
        newPrice: "$48.85",
        rating: 2
    },
    {
        id: 6,
        title: "Frozen vegetables broccoli, spinach",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-16-1.jpg",
        oldPrice: "$75.00",
        newPrice: "$71.00",
        rating: 1
    },
    {
        id: 7,
        title: "All Natural Style Chicken Meatballs",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-2-1.jpg",
        oldPrice: "$52.80",
        newPrice: "$52.85",
        rating: 3
    },
    {
        id: 8,
        title: "Blue Almonds Lightly Salted Vegetables",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-5-1.jpg",
        oldPrice: "$25.80",
        newPrice: "$23.85",
        rating: 1
    },
    {
        id: 9,
        title: "Gorton’s Beer Battered Fish Fillets",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-9-1.jpg",
        oldPrice: "$25.80",
        newPrice: "$23.85",
        rating: 0
    },
    {
        id: 10,
        title: "Gorton’s Beer Battered Fish Fillets",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-9-1.jpg",
        oldPrice: "$25.80",
        newPrice: "$23.85",
        rating: 0
    },
    {
        id: 11,
        title: "Angie’s Sweet & Salty Kettle Corn",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-3-1.jpg",
        oldPrice: "$52.80",
        newPrice: "$48.85",
        rating: 2
    },
    {
        id: 12,
        title: "Organic Cage Grade A Large Eggs",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/product-20-4-min.jpg",
        oldPrice: "$24.00",
        newPrice: "$21.00",
        rating: 1
    },

];

const ListCard_2 = () => {
    return (
        <div className="list-card-2 flex j-between a-center">
            {product.map((val) => (
                <Card_2
                    key={val.id}
                    img={val.img}
                    id={val.id}
                    title={val.title}
                    oldPrice={val.oldPrice}
                    newPrice={val.newPrice}
                    rating={val.rating}
                />
            ))}
        </div>
    );
};

export default ListCard_2;
