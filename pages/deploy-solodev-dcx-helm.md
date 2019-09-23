# Deploy Solodev DCX on an EKS Cluster via Helm Charts
The following steps will allow you to deploy Solodev DCX to an existing EKS cluster via Helm Charts. Additional installation methods are available including <a href="deploy-solodev-dcx.md">via AWS CloudFormation</a> or via <a href="deploy-solodev-dcx-kcmd.md">custom kubectl commands</a>.

These instructions presume you already have installed Helm, Kubernetes, the Kubernetes command-line tool, and the <a href="https://aws.amazon.com/cli/">AWS Command Line Interface (AWS CLI)</a>.

## Step 1: Subscribe on the AWS Marketplace
Solodev is a professionally managed, enterprise-class Digital Customer Experience Platform and content management system (CMS). Before launching one of our products, you'll first need to subscribe to Solodev on the <a href="#">AWS Marketplace.</a> Click the button below to get started: 
<table>
	<tr>
		<td width="60%"><a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/AWS_Marketplace_Logo.jpg" /></a></td>
		<td><a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Subscribe_Large.jpg" /></a></td>
	</tr>
</table>

## Step 2: Retrive Solodev Helm Charts
Run the following commands from within your Kubernetes cluster:
<pre>
helm repo add charts 'https://raw.githubusercontent.com/techcto/charts/master/'
helm repo update
helm repo list
</pre>

## Step 3: Deploy Solodev DCX on your Kubernetes Cluster
Run the following command from within your Kubernetes cluster, specifying namespace, name, appSecret, appPassword, dbPassword values, and serviceAccountName values. Visiting the <a href="https://aws.amazon.com/blogs/opensource/introducing-fine-grained-iam-roles-service-accounts/">"Introducing Fine-Grained IAM Roles for Service Accounts"</a> AWS blog post for instructions on creating your serviceAccountName.
<pre>
helm install --namespace solodev-dcx --name solodev1 charts/solodev-dcx-aws \
                --set serviceAccountName='solodev-serviceaccount' \
                --set solodev.settings.appSecret=secret \
                --set solodev.settings.appPassword=password \
                --set solodev.settings.dbPassword=password
</pre>

## Step 4: Retrieve the External Endpoints of the "ui" Service
In addition to the other services deployed, Solodev DCX will deploy a "ui" service. This service will output external endpoints that you can use to access Solodev DCX. 

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/eks-external-endpoints.jpg" /></td>
	</tr>
</table>

## Step 5: Login to Solodev 
Visit the external endpoint retrived in step 4 to load Solodev DCX. Use the the username "solodev" and the appPassword specified during step 3 for login credentials.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/login-solodev-cms-eks.jpg" /></td>
	</tr>
</table>