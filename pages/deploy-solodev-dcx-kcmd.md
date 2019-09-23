# Deploy Solodev DCX on an EKS Cluster via Custom kubectl commands
The following steps will allow you to deploy Solodev DCX to an existing EKS cluster via a custom set of kubectl commands. Additional installation methods are available including <a href="deploy-solodev-dcx.md">via AWS CloudFormation</a> or via <a href="deploy-solodev-dcx-helm.md">Helm Charts</a>.

These instructions presume you already have installed <a href="https://helm.sh/">Helm</a>, <a href="https://kubernetes.io/">Kubernetes</a>, and the <a href="https://kubernetes.io/docs/tasks/tools/install-kubectl/">Kubernetes command-line tool</a>.

## Step 1: Subscribe on the AWS Marketplace
Solodev is a professionally managed, enterprise-class Digital Customer Experience Platform and content management system (CMS). Before launching one of our products, you'll first need to subscribe to Solodev on the <a href="#">AWS Marketplace.</a> Click the button below to get started: 
<table>
	<tr>
		<td width="60%"><a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/AWS_Marketplace_Logo.jpg" /></a></td>
		<td><a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Subscribe_Large.jpg" /></a></td>
	</tr>
</table>

## Step 2: Download the Solodev DCX Custom kcmd.sh Script
Access and download the <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/eks/bin/kcmd.sh">Solodev DCX custom kcmd.sh script</a>. Place the shell script inside a directory you will use to access your Kubernetes cluster.

Modify lines 5-21 with values specific to your environment. Lines 5-12 correspond to the values used to launch Solodev DCX. Line 15 corresponds to the region you want to launch within. Lines 18-21 correspond to the values of your Kubernetes cluster, which can be retrieved as <a href="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/outputs-solodev-cms-eks.jpg">stack outputs</a> if the cluster was launched via CloudFormation.

<pre>
export RELEASE="solodev-dcx-aws"
export NAMESPACE="solodev-dcx"
export KUBECONFIG="eksconfig"
export DOMAINNAME="domain.com"
export DOMAINID="config"
export SECRET="BigSecret123"
export PASSWORD="password"
export DBPASSWORD="password"

#AWS
export Region="us-east-1"

#GET VALUES FROM CLOUDFORMATION OUTPUT OF EKS STACK
export CAData=""
export EKSEndpoint=""
export EKSName=""
export ControlPlaneProvisionRoleArn=""
</pre>

## Step 3: Deploy Solodev DCX on your Kubernetes Cluster
From command line and inside the directory that has the kcmd.sh script, run the following to provides access to the Kubernetes API via an HTTP proxy:
<pre>
./kcmd.sh proxy
</pre>

Open a new separate terminal to run the following two commands. The proxy must remain open while the following two commands execute.

From command line and inside the directory that has the kcmd.sh script, run the following to download the necessary Helm Charts and configure a needed config file:
<pre>
./kcmd.sh init
</pre>

From command line and inside the directory that has the kcmd.sh script, run the following to install Solodev DCX:
<pre>
./kcmd.sh install solodev-dcx
</pre>

## Step 4: Retrieve the External Endpoints of the "ui" Service
In addition to the other services deployed, Solodev DCX will deploy a "ui" service. This service will output external endpoints that you can use to access Solodev DCX. 

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/eks-external-endpoints.jpg" /></td>
	</tr>
</table>

## Step 5: Login to Solodev 
Visit the external endpoint retrived in step 4 to load Solodev DCX. Use the the username "solodev" and the PASSWORD specified during step 2 for login credentials.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/login-solodev-cms-eks.jpg" /></td>
	</tr>
</table>