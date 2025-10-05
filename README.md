...

1. Create service from Github Repo
2. Attach volume
3. Setting add TCP Proxy (27017)
4. Set Environment Variables
```
MONGO_INITDB_ROOT_PASSWORD=${{ secret(32, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") }}
MONGO_INITDB_ROOT_USERNAME="mongo"
MONGO_PUBLIC_URL="mongodb://${{MONGO_INITDB_ROOT_USERNAME}}:${{MONGO_INITDB_ROOT_PASSWORD}}@${{RAILWAY_TCP_PROXY_DOMAIN}}:${{RAILWAY_TCP_PROXY_PORT}}"
MONGO_URL="mongodb://${{MONGO_INITDB_ROOT_USERNAME}}:${{MONGO_INITDB_ROOT_PASSWORD}}@${{RAILWAY_PRIVATE_DOMAIN}}:27017"
MONGOHOST="${{RAILWAY_PRIVATE_DOMAIN}}"
MONGOPASSWORD="${{MONGO_INITDB_ROOT_PASSWORD}}"
MONGOPORT="27017"
MONGOUSER="${{MONGO_INITDB_ROOT_USERNAME}}"
```
5. Railway SSH
6. Run `mongosh "mongodb://mongo:YOUR_PASSWORD@mongodb-single-replica-railway.railway.internal:27017"`
7. Run initiate command
```
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb-single-replica-railway.railway.internal:27017" }
  ]
})
```
8. `rs.status()`
9. Test in MongoDB Compass with params `?directConnection=true&retryWrites=false`
