# MongoDB Single Replica Set on Railway

If you want to use features like **Transactions** in MongoDB, you need to set up a **Replica Set**.
This also requires a **Keyfile** for authentication between nodes.

## Simple Steps in the Dockerfile

1. **Create the Keyfile**
   - Generate a random key.
   - Save it into a file that MongoDB will use for internal authentication.

2. **Set File Permissions**
   - Change ownership of the Keyfile to the `mongodb` user.
   - Restrict permissions so only MongoDB can access it.

3. **Run Docker with Replica Set + Authentication**
   - Start the MongoDB container with parameters to:
     - Enable **Replica Set mode**.
     - Enable **Authentication**.
     - Use the **Keyfile** for node-to-node communication.

### Prerequisites:
- Railway CLI (`brew install railway`)

---

### How to use:
1. Create service from `https://github.com/takzobye/mongodb-single-replica-railway`
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
6. Connect to MongoDB
```
mongosh "mongodb://mongo:YOUR_PASSWORD@mongodb-single-replica-railway.railway.internal:27017"
```
7. Run initiate replica set command
```
rs.initiate({
  _id: "rs0",
  members: [
    { _id: 0, host: "mongodb-single-replica-railway.railway.internal:27017" }
  ]
})
```
8. Check status with `rs.status()`
9. Test in MongoDB Compass with params `?directConnection=true&retryWrites=false`
