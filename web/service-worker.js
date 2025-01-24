const CACHE_NAME = "ukhsc-mobile-app-v1";
const SHARED_DATA_KEY = "pwa-installed";

self.addEventListener("install", (event) => {
  console.log("[ServiceWorker] Install");
  event.waitUntil(self.skipWaiting());
});

self.addEventListener("activate", (event) => {
  console.log("[ServiceWorker] Activate");
  event.waitUntil(self.clients.claim());
});

self.addEventListener("fetch", (event) => {
  const url = new URL(event.request.url);
  
  if (url.pathname === '/pwa-status') {
    event.respondWith(
      (async () => {
        const cache = await caches.open(CACHE_NAME);
        
        if (event.request.method === "POST") {
          const clonedReq = event.request.clone();
          const data = await clonedReq.json();
          await cache.put(SHARED_DATA_KEY, new Response(JSON.stringify(data)));
          return new Response(JSON.stringify({ success: true }));
        }
        
        const cached = await cache.match(SHARED_DATA_KEY);
        return cached || new Response(JSON.stringify({ installed: false }));
      })()
    );
  }
});
