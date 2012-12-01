## 0.0.2 (Dec 1, 2012)

Features:
- returns an array of re-hydrated ruby objects from redis with `Castache.mget`
  when given an array of cache keys

## 0.0.1 (Nov 30, 2012)

_initial release!_

Features:
- marshals object to redis with `Catache.set`
- returns re-hydrated ruby object from redis with `Castache.get`
- returns re-hydrated ruby object with `Castache.fetch` and will set contents of
  the block you pass in if the object does not exist in the cache
