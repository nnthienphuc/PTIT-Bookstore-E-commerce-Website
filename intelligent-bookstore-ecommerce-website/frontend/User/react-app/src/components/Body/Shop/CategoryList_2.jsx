import CategoryItem_2 from "./CategoryItem_2"
import "./Categories_2.scss"
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";
const catagories = [
    {
        name: "Milks and Dairies",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-1.png",
        item: "5 items",
    },
    {
        name: "Wines & Alcohol",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-2.png",
        item: "4 items",
    },
    {
        name: "Clothing & Beauty",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-3.png",
        item: "4 items",
    },
    {
        name: "Pet Foods & Toy",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-4.png",
        item: "2 items",
    },
    {
        name: "Packaged fast food",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-5.png",
        item: "11 items",
    },
    {
        name: "Baking material",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-6.png",
        item: "11 items",
    },
    {
        name: "Vegetables & tubers",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-7.png",
        item: "6 items",
    },
    {
        name: "Fress Seafood",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-8.png",
        item: "5 items",
    },
    {
        name: "Ice Cream",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-11.png",
        item: "8 items",
    },
    {
        name: "Milks and Dairies",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-1.png",
        item: "5 items",
    },
    {
        name: "Wines & Alcoho",
        img: "https://themepanthers.com/wp/nest/d2/wp-content/uploads/2022/05/category-2.png",
        item: "4 items",
    },


]

const CategoryList = () => {
    const settings = {
        slidesToShow: 8,
        slidesToScroll: 1,
        dots: false,



    };
    return (


        <div className="category-2">
            <Slider {...settings}>
                {catagories.map((val) => (
                    <CategoryItem_2 key={val.name} img={val.img} name={val.name} item={val.item} />
                ))}
            </Slider>
        </div>



    )
}
export default CategoryList