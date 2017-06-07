![alt text](.github/readme.png?raw=trueg "pws logo")

## About
A starting point  to get you started with creating or converting your existing website/webapp into a Progressive Web App. Includes a service worker template.



## Getting Started

A full example of all this is seen [here]()
Remember the mainfest.json and serverwork.js need to be at the root.

### 1. Create a mainfest.json file

You can see a full list of features  [here](https://developers.google.com/web/fundamentals/engage-and-retain/web-app-manifest/)

```

{
  "short_name": "PWA Template",
  "name": "Teamwork.com - PWA Template",
  "background_color": "#fafafa",
  "theme_color": "#65d656",
  "display": "standalone",
  "orientation": "portrait",
  "scope": "./",
  "gcm_user_visible_only": true,
  "gcm_sender_id": "xxxxxxx",
  "applicationServerKey":"xxxxxxx",
  "icons": [
    {
      "src": "assets/images/16.png",
      "type": "image/png",
      "sizes": "16x16"
    },
    {
      "src": "assets/images/32.png",
      "type": "image/png",
      "sizes": "32x32"
    },
    {
      "src": "assets/images/144.png",
      "type": "image/png",
      "sizes": "144x144"
    },
    {
      "src": "assets/images/152.png",
      "type": "image/png",
      "sizes": "152x152"
    },
    {
      "src": "assets/images/196.png",
      "type": "image/png",
      "sizes": "196x196"
    },
    {
      "src": "assets/images/512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ],
  "start_url": "https://teamwork.github.io/progressive-web-app-template/",
  "description": "A starting point to get you started with creating or converting your existing website/webapp into a Progressive Web App. Includes a service worker template.",
  "prefer_related_applications": true,
  "related_applications": [
    {
    "platform": "play",
    "id": "xxxx"
    }
  ]
}

```

### 2. Add the manifest.json

Add the manifest.json reference to the index.html file’s head tag:

```
<link rel="manifest" href="./manifest.json">
```


### 3. Add a Service Worker

To get started with service workers, you first need to create a service worker’s JavaScript file. Will be placed in the root. You can see one [here]()

```


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
  var cacheFiles, cacheName;

  cacheFiles = ['https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css', 'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'];

  cacheName = 'v1.00';

  self.addEventListener('install', function(e) {
    e.waitUntil(caches.open(cacheName).then(function(cache) {
      return cache.addAll(cacheFiles);
    }));
  });

  self.addEventListener('push', function(event) {
    var title;
    title = 'Update From Teamwork.com';
    event.waitUntil(self.registration.showNotification(title, {
      body: 'Click to read the latest update',
      icon: './assets/images/favicons/196.png',
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
    return;
    event.respondWith(fetch(event.request)["catch"](function() {
      return caches.match(event.request);
    }));
  });

}).call(this);

```

### 4. Now register the service worker

You can add this file to load event in your javascript of html.


```


  var ServiceWorker;

  ServiceWorker = (function() {

    function ServiceWorker() {

      if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/serviceWorker.js').then((function(_this) {
          return function(registration) {
            if (registration.installing) {
              console.log('Service worker installing');
            } else if (registration.waiting) {
              console.log('Service worker installed');
            } else if (registration.active) {
              console.log('Service worker active');
              console.log(registration);
              console.log('Service Worker Registered');
              _this.subscribe(registration);
            }
          };
        })(this))["catch"](function(err) {
          console.log('Service Worker Failed to Register', err);
        });
      }
      return;
    }

    ServiceWorker.prototype.unsubscribe = function(serviceWorkerReg) {
      if ('serviceWorker' in navigator) {
        serviceWorkerReg.pushManager.getSubscription().then(function(subscription) {
          subscription.unsubscribe();
        });
      }
    };

    ServiceWorker.prototype.subscribe = function(serviceWorkerReg) {
      if ('serviceWorker' in navigator) {
        serviceWorkerReg.pushManager.subscribe({
          userVisibleOnly: true
        }).then(function(subscription) {});
        return;
      }
    };

    return ServiceWorker;

  })();
  return new ServiceWorker();




```



### 5. Now reload

You could see in the network tab. The Service worker is taking care of loading of the assets.


## Lighthouse
Lighthouse is an open-source, automated tool for improving the performance, quality, and correctness of your web apps. 

When auditing a page, Lighthouse runs a barrage of tests against the page, and then generates a report on how well the page did. From here you can use the failing tests as indicators on what you can do to improve your app. 

### Installl plugin

```
npm install -g GoogleChrome/lighthouse
```

### Run the audit

```
npm explore -g lighthouse -- npm run chrome
lighthouse https://github.com/Teamwork/progressive-web-app-template
```

## Getting to know the terms

### Web App Manifest

A web app manifest file is a simple JSON file that follows the W3C’s specification.

To display the installation prompt, your web app needs to:
- have a valid web app manifest file,
- be served over HTTPS,
- have a valid service worker registered,
- have been visited twice, with at least five minutes between each visit.

### What is a Progressive Web App?

Progressive Web App (PWA) is a term used to denote web apps that uses the latest web technologies. Progressive web apps are technically regular web pages (or websites) but can appear to the user like traditional applications or (native) mobile applications.


### What is a Service Worker?

A service worker is a script that your browser runs in the background, separate from a web page, opening the door to features that don't need a web page or user interaction. Today, they already include features like push notifications and background sync.


