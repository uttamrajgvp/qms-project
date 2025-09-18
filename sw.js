const CACHE_NAME = 'quailtymed-v2';
const API_CACHE_NAME = 'quailtymed-api-v1';

const urlsToCache = [
    '/',
    '/index.html',
    '/css/style.css',
    '/js/app.js',
    '/js/api.js',
    '/manifest.json',
    'https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js',
    'https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js'
];

// During the install phase, cache all static assets required for the app shell.
self.addEventListener('install', (event) => {
    console.log('[Service Worker] Install Event');
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('[Service Worker] Caching App Shell assets');
                return cache.addAll(urlsToCache);
            })
            .catch(error => {
                console.error('[Service Worker] Failed to cache assets:', error);
            })
    );
    self.skipWaiting();
});

// The fetch event is triggered for every network request made by the app.
self.addEventListener('fetch', (event) => {
    const url = new URL(event.request.url);

    // Differentiate between API requests and static asset requests.
    if (url.origin === location.origin && url.pathname.startsWith('/api/')) {
        // For API requests, use a 'network-falling-back-to-cache' strategy.
        // This ensures the app tries to get the latest data first, but
        // will still function offline with the last cached data.
        event.respondWith(
            fetch(event.request)
                .then(response => {
                    // Cache the new API response for future use.
                    const responseToCache = response.clone();
                    caches.open(API_CACHE_NAME).then(cache => {
                        cache.put(event.request, responseToCache);
                    });
                    return response;
                })
                .catch(() => {
                    // If network fails, try to return a response from the API cache.
                    return caches.match(event.request);
                })
        );
    } else {
        // For static assets, use a 'cache-first' strategy.
        // This serves the app shell instantly from the cache.
        event.respondWith(
            caches.match(event.request)
                .then((response) => {
                    if (response) {
                        return response; // Cache hit - return cached response.
                    }
                    
                    // If not in cache, fetch from the network.
                    const fetchRequest = event.request.clone();
                    return fetch(fetchRequest).then(
                        (response) => {
                            if (!response || response.status !== 200 || response.type !== 'basic') {
                                return response;
                            }
    
                            // Cache the new response for future use.
                            const responseToCache = response.clone();
                            caches.open(CACHE_NAME).then((cache) => {
                                cache.put(event.request, responseToCache);
                            });
                            return response;
                        }
                    );
                })
        );
    }
});

// The activate event is for cleaning up old caches.
self.addEventListener('activate', (event) => {
    console.log('[Service Worker] Activate Event');
    const cacheWhitelist = [CACHE_NAME, API_CACHE_NAME];
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheWhitelist.indexOf(cacheName) === -1) {
                        console.log(`[Service Worker] Deleting old cache: ${cacheName}`);
                        return caches.delete(cacheName);
                    }
                })
            );
        })
    );
    self.clients.claim();
});
