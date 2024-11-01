// src/components/Sidebar.js
import React from 'react';
import './Sidebar.css';

function Sidebar({ openPage }) {
    return (
        <aside>
            <div className="top">
                <div className="logo">
                    <img src="img/logo.png" alt="Logo" />
                    <h2 className="text-muted">NAPU <span className="danger">NO</span></h2>
                </div>
            </div>
            <div className="sidebar">
                <a onClick={() => openPage("https://example.com")}>
                    <span className="material-icons-sharp">menu_book</span>
                    <h3> Book</h3>
                </a>
                <a href="#" className="active">
                    <span className="material-icons-sharp">category</span>
                    <h3> Category</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">person_outline</span>
                    <h3> Author</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">sell</span>
                    <h3> Promotion</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">home</span>
                    <h3> Publisher</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">group</span>
                    <h3> Customer</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">receipt_long</span>
                    <h3> Invoice</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">account_circle</span>
                    <h3> Account</h3>
                </a>
                <a href="#">
                    <span className="material-icons-sharp">logout</span>
                    <h3> Logout</h3>
                </a>
            </div>
        </aside>
    );
}

export default Sidebar;
