docker build -t inazrabuu/multi-client:latest -t inazrabuu/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t inazrabuu/multi-server:latest -t inazrabuu/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t inazrabuu/multi-worker:latest -t inazrabuu/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push inazrabuu/multi-client:latest
docker push inazrabuu/multi-client:$SHA
docker push inazrabuu/multi-server:latest
docker push inazrabuu/multi-server:$SHA
docker push inazrabuu/multi-worker:latest
docker push inazrabuu/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=inazrabuu/multi-client:$SHA
kubectl set image deployments/server-deployment server=inazrabuu/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=inazrabuu/multi-worker:$SHA