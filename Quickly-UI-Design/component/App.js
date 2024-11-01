// src/App.js
import React, { useState } from 'react';
import Navbar from './components/Navbar';
import Sidebar from './components/Sidebar';
import Content from './components/Content';
import './App.css';

function App() {
    const [url, setUrl] = useState("");

    const openPage = (newUrl) => {
        setUrl(newUrl);
    };

    return (
        <div className="container">
            <Sidebar openPage={openPage} />
            <main>
                <Navbar />
                <Content url={url} />
            </main>
        </div>
    );
}

export default App;
