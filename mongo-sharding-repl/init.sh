#!/bin/bash

echo "Initiating replica sets"

docker compose exec -T configSrv mongosh --port 27017 <<EOF
rs.initiate({
    _id : "config_server",
    configsvr: true,
    members: [
        { _id : 0, host : "configSrv:27017" }
    ]
});
exit();
EOF


echo "Initiating hard1 replica"
sleep 5

docker compose exec -T shard1_replica1 mongosh --port 27018 <<EOF
rs.initiate({
    _id : "shard1",
    members: [
        { _id : 0, host : "shard1_replica1:27018" },
        { _id : 1, host : "shard1_replica2:27019" },
        { _id : 2, host : "shard1_replica3:27020" }
    ]
});
exit();
EOF

echo "Initiating hard2 replica"
sleep 5

docker compose exec -T shard2_replica1 mongosh --port 27021 <<EOF
rs.initiate({
    _id : "shard2",
    members: [
        { _id : 0, host : "shard2_replica1:27021" },
        { _id : 1, host : "shard2_replica2:27022" },
        { _id : 2, host : "shard2_replica3:27023" }
    ]
});
exit();
EOF

echo "Initiating mongos router"
sleep 5

docker compose exec -T mongos_router mongosh --port 27024 <<EOF
    sh.addShard("shard1/shard1_replica1:27018");
    sh.addShard("shard2/shard2_replica1:27021");
    exit();
EOF

echo "Initiating DB in router"
sleep 5

docker compose exec -T mongos_router mongosh --port 27024 <<EOF
    sh.enableSharding("somedb");
    sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
    exit();
EOF

echo "Initiating data in DB"
sleep 1

docker compose exec -T mongos_router mongosh --port 27024 <<EOF
    use somedb;
    for(var i = 0; i < 1000; i++) db.helloDoc.insert({age:i, name:"ly"+i});
    exit();
EOF
