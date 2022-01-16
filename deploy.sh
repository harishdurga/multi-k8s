docker build -t harishdurga/multi-client:latest -t harishdurga/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t harishdurga/multi-server:latest -t harishdurga/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harishdurga/multi-worker:latest -t harishdurga/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push harishdurga/multi-client:latest
docker push harishdurga/multi-server:latest
docker push harishdurga/multi-worker:latest

docker push harishdurga/multi-client:$SHA
docker push harishdurga/multi-server:$SHA
docker push harishdurga/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=harishdurga/multi-server:$SHA
kubectl set image deployments/client-deployment client=harishdurga/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=harishdurga/multi-worker:$SHA