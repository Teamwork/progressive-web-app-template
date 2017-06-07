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


