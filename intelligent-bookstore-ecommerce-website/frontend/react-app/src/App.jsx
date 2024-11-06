import "./App.scss"
import Header from "./components/Header/Header"
import Body from "./components/Body/Body"
import Footer from "./components/Footer/Footer"
import SideMenuAction from "./components/SideMenuAction/SideMenuAction"
import ToTop from "./components/ToTop/ToTop"
import { useEffect, useState } from "react"
import "./reset.css"
function ReactApp() {

  const [isHideMenu, setIsHideMenu] = useState(false)
  const [isHideToTop, setIsHideToTop] = useState(false)

  useEffect(() => {
    document.addEventListener("scroll", () => {
      const positionY = window.scrollY;
      if (positionY > 300) {
        setIsHideToTop(false)
      } else {
        setIsHideToTop(true)
      }
      if (positionY > 400) {
        setIsHideMenu(true)
      } else {
        setIsHideMenu(false)
      }
    });
  }, []);
  return (
    <div>
      <Header />
      <Body />
      <Footer />
      <SideMenuAction style={{
        opacity: isHideMenu ? 0 : 1,
        visibility: isHideMenu ? "hidden" : "visible",
        transform: isHideMenu ? "translateY(50px)" : "translateY(0)",
      }} />
      <ToTop style={{
        opacity: isHideToTop ? 0 : 1,
        visibility: isHideToTop ? "hidden" : "visible",
        transform: isHideToTop ? "translateY(100px)" : "translateY(0)",
      }} />
    </div>
  )
}

export default ReactApp