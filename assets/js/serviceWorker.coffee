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


# Default files to always cache
cacheFiles = [

    'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'
    'https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'
]

cacheName = 'v1.00' # Caching number for the service Worker


##
# Function for the installing of the serivce worker
# @param {event} e
# @return {none} none
##
self.addEventListener 'install', (e) ->
    e.waitUntil caches.open(cacheName).then((cache) ->
        # Add all the default files to the cache
        cache.addAll cacheFiles
    )
    return


##
# Function for the push event of the serivce worker
# @param { event } e
# @return {} none
##
self.addEventListener 'push', (event) ->

    title = 'Update From Teamwork.com'
    event.waitUntil self.registration.showNotification(title,
        body: 'Click to read the latest update'
        icon: './assets/images/favicons/196.png'
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
# Function for fetching
# Scripts, css, images and asset
# @param { event } e
# @return {} none
##
self.addEventListener 'fetch', (event) ->

    return

    event.respondWith fetch(event.request).catch(->
        caches.match event.request
    )
    return