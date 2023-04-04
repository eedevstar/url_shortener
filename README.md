# Requirement

A Simple Way to Shorten Long URLs in RAILS.
URL shortener solves the problem of sharing the long website URLs by shortening them into a more portable size.

1. Given a URL, our service should generate a short and unique alias of it. We will call it a short link. This link should be short enough to be easily copied and distributed by our end user.
2. Shortened links should be publicly accessible. When users access a short link, our service should redirect them to the original link.
3. Users should optionally be able to pick a custom short link for their URL.
4. Links should expire after a default timespan of 30 days. Users should be able to specify a different expire time.
5. Service should collect metrics like most clicked links
6. Shortened links should not be guessable (not predictable)

# Additional comments and hints
1. For the demonstration purposes, please assume that only authorized users can create or modify shortened links but please don't bother about security too much - even the simplest authentication method should be sufficient.
2. It's also okay to omit the non-essential parts like user management - in that case a simpe seed file is enough

# Set up the app
This app is developed 
* Ruby - 3.1.3
* Rails - 7.0.4.3
* Added 2 Models, User & ShortenedUrl
* Added Simple User Authentication
* gest users can see & click the shortened urls

## Run the app

```sh
% bin/rails db:prepare
% bin/rails db:fixtures:load
% bin/rails server -d
```
