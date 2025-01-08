#!/bin/bash

docker compose exec -T shard1_replica1 mongosh --port 27018 <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

docker compose exec -T shard1_replica2 mongosh --port 27019  <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

docker compose exec -T shard1_replica3 mongosh --port 27020 <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

docker compose exec -T shard2_replica1 mongosh --port 27021  <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

docker compose exec -T shard2_replica2 mongosh --port 27022 <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF

docker compose exec -T shard2_replica3 mongosh --port 27013  <<EOF
use somedb;
db.helloDoc.countDocuments();
EOF
