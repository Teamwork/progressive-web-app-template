
/*

   88
  I88I
 888I8888
  I88I  ggG   gg   gg
  I88I  I8I   I8   88,   Hello friend!
  I88I, I8I   I8   8I,   You seem like the type of curious person that we like
  8888b, d8I, ,d8,,D8    So why not come join us?! - see https://www.teamwork.com/jobs
   Y888P  Y88P""Y8P"     Handcrafted with ♥ in Cork, Ireland.. ps, we are fans of the Konami code.
 */

(function() {
  var cacheFiles, cacheName, offlineUrl;

  cacheName = 'v1.29';

  offlineUrl = 'offline.html';

  cacheFiles = [];

  self.addEventListener('install', function(e) {
    e.waitUntil(caches.open(cacheName).then(function(cache) {
      return cache.addAll([cacheFiles, offlineUrl]);
    }));
  });

  self.addEventListener('push', function(event) {
    var title;
    title = 'Hey';
    event.waitUntil(self.registration.showNotification(title, {
      body: 'Click to read the latest update',
      icon: './assets/images/196.png',
      tag: 'new-article'
    }));
  });

  self.addEventListener('activate', function(e) {
    e.waitUntil(caches.keys().then(function(cacheNames) {
      return Promise.all(cacheNames.map(function(thisCacheName) {
        if (thisCacheName !== cacheName) {
          return caches["delete"](thisCacheName);
        }
      }));
    }));
  });

  self.addEventListener('notificationclick', function(event) {
    var url;
    event.notification.close();
    url = './index.html?notification=true';
    event.waitUntil(clients.matchAll({
      type: 'window'
    }).then(function(windowClients) {
      var client, i;
      i = 0;
      while (i < windowClients.length) {
        client = windowClients[i];
        if (client.url === url && 'focus' in client) {
          return client.focus();
        }
        i++;
      }
      if (clients.openWindow) {
        return clients.openWindow(url);
      }
    }));
  });

  self.addEventListener('fetch', function(event) {
    console.log(event);
    if (event.request.mode === 'navigate' || event.request.method === 'GET' && event.request.headers.get('accept').includes('text/html')) {
      event.respondWith(fetch(event.request.url)["catch"](function() {
        return caches.match(offlineUrl);
      }));
    } else {
      event.respondWith(fetch(event.request)["catch"](function() {
        console.log(event.request);
        return caches.match(event.request);
      }));
    }
  });

}).call(this);
