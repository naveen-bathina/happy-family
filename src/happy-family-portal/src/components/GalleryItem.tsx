// src/components/GalleryItem.tsx

import React from 'react';

interface GalleryItemProps {
    type: 'image' | 'video';
    src: string;
}

const GalleryItem: React.FC<GalleryItemProps> = ({ type, src }) => {
    return (
        <div style={{ position: 'relative', borderRadius: 8, overflow: 'hidden' }}>
            {type === 'image' ? (
                <img src={src} alt="gallery item" style={{ width: '100%', borderRadius: 8 }} />
            ) : (
                <video src={src} controls style={{ width: '100%', borderRadius: 8 }} />
            )}
        </div>
    );
};

export default GalleryItem;
