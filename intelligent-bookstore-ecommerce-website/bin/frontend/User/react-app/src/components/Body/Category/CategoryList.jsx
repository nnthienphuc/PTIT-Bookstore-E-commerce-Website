import CategoryItem from "./CategoryItem"
import "./Category.scss"
const catagories = [
    {
        name: "Baking material",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-2.png",
        badge: 11,
    },
    {
        name: "Bread and Juice",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-11.png",
        badge: 8,
    },
    {
        name: "Clothing & beauty",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-3.png",
        badge: 4,
    },
    {
        name: "Deals Of The Day",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-1.png",
        badge: 4,
    },
    {
        name: "Fresh Fruit",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-7.png",
        badge: 10,
    },
    {
        name: "Fresh Seafood",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-10.png",
        badge: 5,
    },
    {
        name: "Milks and Dairies",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-6.png",
        badge: 5,
    },
    {
        name: "Pet Foods & Toy",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-4.png",
        badge: 2,
    },
    {
        name: "Vegetables",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-8.png",
        badge: 6,
    },
    {
        name: "Wines & Drinks",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-9.png",
        badge: 4,
    },
    {
        name: "Uncategorized",
        img: "	https://themepanthers.com/wp/nest/d2/wp-content/uploads/woocommerce-placeholder-300x300.png",
        badge: 15,
    },
]

const CategoryList = () => {
    return (
        <div className="category-tag">
            {catagories.map((val) => (
                <CategoryItem key={val.name} img={val.img} name={val.name} badge={val.badge} />
            ))}
        </div>
    )
}
export default CategoryList