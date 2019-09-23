# Deploy Solodev DCX on an EKS Cluster via Helm Charts
The following steps will allow you to deploy Solodev DCX to an existing EKS cluster via Helm Charts. Additional installation methods are available including <a href="deploy-solodev-dcx.md">via AWS CloudFormation</a> or via <a href="deploy-solodev-dcx-kcmd.md">custom k commands</a>.

These instructions presume you already have installed Helm, Kubernetes, and the Kubernetes command-line tool.

## Step 1: Retrive Solodev Helm Charts
Run the following commands from within your Kubernetes cluster:
<pre>
helm repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
helm repo update
helm repo list
</pre>

## Step 2: Deploy Solodev DCX on your Kubernetes cluster
Run the following command from within your Kubernetes cluster:
<pre>
helm install --namespace solodev-dcx --name solodev1 charts/solodev-dcx-aws \
                --set solodev.settings.appSecret=secret \
                --set solodev.settings.appPassword=password \
                --set solodev.settings.dbPassword=password
</pre>