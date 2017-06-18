###

   88
  I88I
 888I8888
  I88I  ggG   gg   gg
  I88I  I8I   I8   88,   Hello friend!
  I88I, I8I   I8   8I,   You seem like the type of curious person that we like
  8888b, d8I, ,d8,,D8    So why not come join us?! - see https://www.teamwork.com/jobs
   Y888P  Y88P""Y8P"     Handcrafted with ♥ in Cork, Ireland.. ps, we are fans of the Konami code.

###
# Set a name for the current cache


cacheName = 'v1.29'

offlineUrl = 'offline.html';


# Default files to always cache
cacheFiles = [
]


##
# Function for the installing of the serivce worker
# @param { event } e
# @return {} none
##
self.addEventListener 'install', (e) ->
    # e.waitUntil Delays the event until the Promise is resolved
    e.waitUntil caches.open(cacheName).then((cache) ->
        # Add all the default files to the cache
        cache.addAll [
            cacheFiles
            offlineUrl
        ]
    )
    # end e.waitUntil
    return


##
# Function for the push event of the serivce worker
# @param { event } e
# @return {} none
##
self.addEventListener 'push', (event) ->

    title = 'Hey'
    event.waitUntil self.registration.showNotification(title,
        body: 'Click to read the latest update'
        icon: './assets/images/196.png'
        tag: 'new-article')
    return


##
# Function for the activate event of the serivce worker
# @param { event } e
# @return {} none
##
self.addEventListener 'activate', (e) ->

    e.waitUntil caches.keys().then((cacheNames) ->
        Promise.all cacheNames.map((thisCacheName) ->
            # If a cached item is saved under a previous cacheName
            if thisCacheName != cacheName
                # Delete that cached file
                return caches.delete(thisCacheName)
            return
        )
    )
    # end e.waitUntil
    return


##
# Function for the notification click
# @param { event } e
# @return {} none
##
self.addEventListener 'notificationclick', (event) ->
    event.notification.close()
    url = './index.html?notification=true'
    event.waitUntil clients.matchAll(type: 'window').then((windowClients) ->
        i = 0
        while i < windowClients.length
            client = windowClients[i]
            if client.url == url and 'focus' of client
                return client.focus()
            i++
        if clients.openWindow
            return clients.openWindow(url)
        return
    )
    return


##
# Function for the fetch the scripts click
# @param { event } e
# @return {} none
##
self.addEventListener 'fetch', (event) ->
    console.log event
    # request.mode = navigate isn't supported in all browsers
    # so include a check for Accept: text/html header.
    if event.request.mode == 'navigate' or event.request.method == 'GET' and event.request.headers.get('accept').includes('text/html')
        event.respondWith fetch(event.request.url).catch( ->
            return caches.match(offlineUrl)
        )
    else
        event.respondWith fetch(event.request).catch(->
            console.log event.request
            caches.match event.request
        )
    return