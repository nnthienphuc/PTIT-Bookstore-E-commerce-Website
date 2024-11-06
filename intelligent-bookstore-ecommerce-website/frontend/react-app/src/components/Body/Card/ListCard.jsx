
import Card from "./Card";
import "../Products/Products.scss"
import { useState } from "react";


const ListCard = () => {
    const allEle = document.querySelector(".All")

    const bakingEle = document.querySelector(".Baking-material")
    const freshEle = document.querySelector(".Fresh-Fruits")
    const milksEle = document.querySelector(".Milks-Dairies")
    const meatsEle = document.querySelector(".Meats")
    const vegetablesEle = document.querySelector(".Vegetables")
    const btnELe = document.querySelectorAll(".action li")
    const product = [
        {
            id: 1,
            title: "Seeds of Change Organic Red Rice",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-1-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-1-2.jpg",
            leftBadge: "13%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Fresh Fruit",
            provier: "NestFood",
            oldPrice: "$32.80",
            newPrice: "$28.85",
            rating: 2,
            type: ["Baking material", "Milks & Dairies"]
        },
        {
            id: 2,
            title: "All Natural Style Chicken Meatballs",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-2-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-2-2.jpg",
            leftBadge: "6%",
            leftBadgeColor: "var(--color-blue)",
            rightBadge: "Sale",
            rightBadgeColor: "var(--primary-color)",
            category: "Bread and Juice",
            provier: "NestFood",
            oldPrice: "$55.80",
            newPrice: "$52.85",
            rating: 5,
            type: ["Baking material", "Milks & Dairies"]
        },
        {
            id: 3,
            title: "Angie’s Sweet & Salty Kettle Corn",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-3-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-3-2.jpg",
            leftBadge: "8%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "New",
            rightBadgeColor: "var(--primary-color)",
            category: "Baking material",
            provier: "Country Crock",
            oldPrice: "$52.80",
            newPrice: "$48.85",
            rating: 4,
            type: ["Baking material", "Milks & Dairies"]
        },
        {
            id: 4,
            title: "Foster Farms Takeout Crispy Classic",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-4-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-4-2.jpg",
            leftBadge: "Out of Stock",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "Country Crock",
            oldPrice: "$19.80",
            newPrice: "$17.85",
            rating: 0,
            type: ["Baking material", "Milks & Dairies"]
        },
        {
            id: 5,
            title: "Blue Almonds Lightly Salted Vegetables",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-5-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-5-2.jpg",
            leftBadge: "Out of Stock",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Fresh Fruit",
            provier: "Country Crock",
            oldPrice: "$25.80",
            newPrice: "$23.85",
            rating: 5,
            type: ["Baking material", "Milks & Dairies"]
        },
        {
            id: 6,
            title: "Chobani Complete Vanilla Greek Yogurt",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-6-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-6-2.jpg",
            leftBadge: "",
            leftBadgeColor: "",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Fresh Fruit",
            provier: "Country Crock",
            oldPrice: "$55.80",
            newPrice: "$54.85",
            rating: 0,
            type: ["Baking material", "Milks & Dairies", "Fresh Fruits"]
        },
        {
            id: 7,
            title: "Haagen Caramel Cone Ice Cream Boxed",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-10-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-10-2.jpg",
            leftBadge: "8%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "Hambger Hel",
            oldPrice: "$24.80",
            newPrice: "$22.85",
            rating: 0,
            type: ["Baking material", "Milks & Dairies", "Fresh Fruits"]
        },
        {
            id: 8,
            title: "Gorton’s Beer Battered Fish Fillets",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-9-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-9-2.jpg",
            leftBadge: "8%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Fresh Seafood",
            provier: "Hambger Hel",
            oldPrice: "$25.80",
            newPrice: "$23.85",
            rating: 0,
            type: ["Baking material", "Fresh Fruits"]
        },
        {
            id: 9,
            title: "Encore Seafoods Stuffed Alaskan",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-8-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-8-2.jpg",
            leftBadge: "6%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Clothing & beauty",
            provier: "Hambger Hel",
            oldPrice: "$37.80",
            newPrice: "$35.85",
            rating: 0,
            type: ["Baking material", "Fresh Fruits"]
        },
        {
            id: 10,
            title: "Canada Dry Ginger Ale – 2 L Bottle",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-7-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-7-2.jpg",
            leftBadge: "3%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "Hambger Hel",
            oldPrice: "$33.80",
            newPrice: "$32.85",
            rating: 0,
            type: ["Baking material", "Fresh Fruits", "Vegetables"]
        },
        {
            id: 11,
            title: "Extra virgin olive oil, canola oil, nonfat",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-12-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-12-2.jpg",
            leftBadge: "4%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "Totino's Pizza",
            oldPrice: "$60.00",
            newPrice: "$58.00",
            rating: 0,
            type: ["Vegetables"]
        },
        {
            id: 12,
            title: "Frozen vegetables broccoli, spinach",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-16-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-16-2.jpg",
            leftBadge: "6%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "Totino's Pizza",
            oldPrice: "$75.00",
            newPrice: "$71.00",
            rating: 2,
            type: ["Vegetables"]
        },
        {
            id: 13,
            title: "Dried fruit: apricots, figs, prunes",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-11-1.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-11-2.jpg",
            leftBadge: "27%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "USA Noodle Soup",
            oldPrice: "$76.00",
            newPrice: "$56.00",
            rating: 4,
            type: ["Vegetables"]
        },
        {
            id: 14,
            title: "Nuts almonds, cashew, pecans",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-20-7-min.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/02/product-20-7-min.jpg",
            leftBadge: "9%",
            leftBadgeColor: "var(--color-orange)",
            rightBadge: "Sale",
            rightBadgeColor: "var(--primary-color)",
            category: "Baking material",
            provier: "Snyder's-Lance",
            oldPrice: "$121.00",
            newPrice: "$111.00",
            rating: 4,
            type: ["Vegetables"]
        },
        {
            id: 15,
            title: "Nestle Coffee Mate Coffee Creamer",
            img1: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/product-20-5-min.jpg",
            img2: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/product-20-5-min.jpg",
            leftBadge: "2%",
            leftBadgeColor: "var(--primary-color)",
            rightBadge: "",
            rightBadgeColor: "",
            category: "Baking material",
            provier: "Totino's Pizza",
            oldPrice: "$53.80",
            newPrice: "$52.80",
            rating: 4,
            type: "Meats"
        },
    ];
    const clearClassActive = () => {
        btnELe.forEach((val) => val.classList.remove("active"))
    }
    const [sortBy, setSortBy] = useState("All")
    let sortedList = []
    if (sortBy === "All") {
        clearClassActive()
        // allEle.classList.add("active")
        sortedList = product
    }
    if (sortBy === "Baking material") {
        clearClassActive()
        bakingEle.classList.add("active")
        sortedList = product.filter((val) => val.type?.includes(sortBy))

    }
    if (sortBy === "Fresh Fruits") {
        clearClassActive()
        freshEle.classList.add("active")
        sortedList = product.filter((val) => val.type?.includes(sortBy))
    }
    if (sortBy === "Milks & Dairies") {
        clearClassActive()
        milksEle.classList.add("active")
        sortedList = product.filter((val) => val.type?.includes(sortBy))
    }
    if (sortBy === "Meats") {
        clearClassActive()
        meatsEle.classList.add("active")
        sortedList = product.filter((val) => val.type?.includes(sortBy))
    }
    if (sortBy === "Vegetables") {
        clearClassActive()
        vegetablesEle.classList.add("active")
        sortedList = product.filter((val) => val.type?.includes(sortBy))
    }

    const handelClick = (e) => {
        setSortBy(e.target.textContent)
    }

    return (
        <div className="popular-product">
            <div className="action flex j-between">
                <h2>Popular Products</h2>
                <nav >
                    <ul className="flex a-center">
                        <li onClick={handelClick} className="All active">All</li>
                        <li onClick={handelClick} className="Baking-material">Baking material</li>
                        <li onClick={handelClick} className="Fresh-Fruits">Fresh Fruits</li>
                        <li onClick={handelClick} className="Milks-Dairies">Milks & Dairies</li>
                        <li onClick={handelClick} className="Meats">Meats</li>
                        <li onClick={handelClick} className="Vegetables">Vegetables</li>
                    </ul>
                </nav>
            </div>
            <div className="row list-card flex  a-center">
                {sortedList?.map((val) => (
                    <Card
                        key={val.id}
                        img1={val.img1}
                        img2={val.img2}
                        id={val.id}
                        leftBadge={val.leftBadge}
                        leftBadgeColor={val.leftBadgeColor}
                        rightBadge={val.rightBadge}
                        rightBadgeColor={val.rightBadgeColor}
                        title={val.title}
                        category={val.category}
                        provier={val.provier}
                        oldPrice={val.oldPrice}
                        newPrice={val.newPrice}
                        rating={val.rating}
                    />
                ))}
            </div>
        </div>

    );
};

export default ListCard;
