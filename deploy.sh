docker build -t bgatelet/multi-client:latest -t bgatelet/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bgatelet/multi-server:latest -t bgatelet/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bgatelet/multi-worker:latest -t bgatelet/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bgatelet/multi-client:latest
docker push bgatelet/multi-server:latest
docker push bgatelet/multi-worker:latest

docker push bgatelet/multi-client:$SHA
docker push bgatelet/multi-server:$SHA
docker push bgatelet/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bgatelet/multi-server:$SHA
kubectl set image deployments/client-deployment client=bgatelet/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bgatelet/multi-worker:$SHA
