import type {MetadataRoute} from 'next';

export default function manifest(): MetadataRoute.Manifest {
    return {
        name: 'GlucoCoach Quick Log',
        short_name: 'GlucoCoach',
        description: 'Quick meal and insulin tracking for GlucoCoach',
        start_url: '/quick-log',
        scope: '/',
        display: 'standalone',
        background_color: '#ffffff',
        theme_color: '#0f766e',
        icons: [
            {
                src: '/icons/icon-192.png',
                sizes: '192x192',
                type: 'image/png',
            },
            {
                src: '/icons/icon-512.png',
                sizes: '512x512',
                type: 'image/png',
            },
        ],
    };
}