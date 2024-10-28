// src/components/Navbar.js
import React from 'react';
import './Navbar.css';

function Navbar() {
    return (
        <nav className="navbar">
            <h1>Dashboard</h1>
            <div className="date">
                <input type="date" />
            </div>
        </nav>
    );
}

export default Navbar;
