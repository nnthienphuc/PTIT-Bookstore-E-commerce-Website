// src/components/Content.js
import React from 'react';

function Content({ url }) {
    return (
        <div className="content">
            <iframe name="contentFrame" src={url} width="100%" height="600px" />
        </div>
    );
}

export default Content;
