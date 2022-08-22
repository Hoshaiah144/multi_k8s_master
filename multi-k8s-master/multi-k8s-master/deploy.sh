docker build -t hoshaiah/multi-client:latest -t hoshaiah/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hoshaiah/multi-server:latest -t hoshaiah/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hoshaiah/multi-worker:latest -t hoshaiah/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hoshaiah/multi-client:latest
docker push hoshaiah/multi-server:latest
docker push hoshaiah/multi-worker:latest

docker push hoshaiah/multi-client:$SHA
docker push hoshaiah/multi-server:$SHA
docker push hoshaiah/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hoshaiah/multi-server:$SHA
kubectl set image deployments/client-deployment client=hoshaiah/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hoshaiah/multi-worker:$SHA