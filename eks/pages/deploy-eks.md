# Deploy EKS Cluster

## Step 1: Launch your CloudFormation Stack
<p align="center"><a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=solodev-eks&templateURL=https://solodev-quickstarts.s3.amazonaws.com/eks/amazon-eks.yaml"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/solodev-launch-btn.png" width="200" /></a></p>

## Step 2: Fill Out the CloudFormation Stack Wizard
<strong>Continue with the preselected CloudFormation Template</strong><br />
The Amazon S3 template URL (used for the CloudFormation configuration) should be preselected. Click "Next" to continue.

<strong>Specify Details</strong><br />
The following parameters must be configured to launch your Solodev DCX CloudFormation stack:

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/parameters-solodev-cms-eks.jpg" /></td>
	</tr>
</table>

<table>
	<tr>
		<th width="33%"><strong>Parameter</strong></th>
		<th width="600px"><strong>Description</strong></th>
	</tr>
	<tr>
		<td>Stack name</td>
		<td>The name of your stack (set to "solodev-eks" by default). Please note, the name must be all lowercase.</td>
	</tr>
</table>

<table>
	<tr>
		<td colspan="2"><strong>Network configuration</strong></td>
	</tr>
	<tr>
		<td width="33%">VPC ID</td>
		<td width="600px">The ID of your existing VPC (e.g., vpc-0343606e)</td>
	</tr>
	<tr>
		<td>Private subnet 1 ID</td>
		<td>The ID of the private subnet in Availability Zone 1 in your existing VPC (e.g., subnet-fe9a8b32)</td>
	</tr>
	<tr>
		<td>Private subnet 2 ID</td>
		<td>The ID of the private subnet in Availability Zone 2 in your existing VPC (e.g., subnet-be8b01ea)</td>
	</tr>
	<tr>
		<td>Public subnet 1 ID</td>
		<td>The ID of the public subnet in Availability Zone 1 in your existing VPC (e.g., subnet-a0246dcd)</td>
	</tr>	
	<tr>
		<td>Public subnet 2 ID</td>
		<td>The ID of the public subnet in Availability Zone 2 in your existing VPC (e.g., subnet-b1236eea)</td>
	</tr>
	<tr>
		<td>Allowed external access CIDR</td>
		<td>The CIDR IP range that is permitted to access the instances. We recommend that you set this value to a trusted IP range.</td>
	</tr>  
</table>

<table>
	<tr>
		<td colspan="2"><strong>Amazon EC2 configuration</strong></td>
	<tr>
		<td width="33%">SSH key name</td>
		<td width="600px">The name of an existing public/private key pair, which allows you to securely connect to your instance after it launches</td>
	</tr>
</table>

<table>
	<tr>
		<td colspan="2"><strong>Amazon EKS configuration</strong></td>
	<tr>
		<td width="33%">Nodes instance type</td>
		<td width="600px">The type of EC2 instance for the node instances.</td>
	</tr>
	<tr>
		<td>Number of nodes</td>
		<td>The number of Amazon EKS node instances. The default is one for each of the three Availability Zones.</td>
	</tr> 
	<tr>
		<td>Node group name</td>
		<td>The name for EKS node group.</td>
	</tr>
	<tr>
		<td>Node volume size</td>
		<td>The size for the node's root EBS volumes.</td>
	</tr>
	<tr>
		<td>Additional EKS admin ARNs</td>
		<td>[OPTIONAL] Comma separated list of IAM user/role Amazon Resource Names (ARNs) to be granted admin access to the EKS cluster</td>
	</tr>
	<tr>
		<td>Kubernetes version</td>
		<td>The Kubernetes control plane version.</td>
	</tr>          
</table>

<table>
	<tr>
		<td colspan="2"><strong>Optional Solodev DCX configuration</strong></td>
	<tr>
		<td width="33%">ProvisionSolodevDCXNetwork</td>
		<td width="600px">Whether or not to also deploy the <a href="deploy-solodev-dcx-network.md">Solodev DCX Network</a>. Recommended to keep "Disabled" unless a Solodev developer.</td>
	</tr>   		
	<tr>
		<td>ZoneName</td>
		<td>(Optional) The Route53 ZoneName that corresponds to the Solodev DCX Network</td>
	</tr>
	<tr>
		<td>ZoneId</td>
		<td>(Optional) The Route53 ZoneID that corresponds to the Solodev DCX Network</td>
	</tr>         
</table>

<table>
	<tr>
		<td colspan="2"><strong>AWS Quick Start configuration</strong></td>
	<tr>
		<td width="33%">Quick Start S3 bucket name</td>
		<td width="600px">S3 bucket name for the Quick Start assets. This string can include numbers, lowercase letters, uppercase letters, and hyphens (-). It cannot start or end with a hyphen (-).</td>
	</tr>
	<tr>
		<td>Quick Start S3 key prefix</td>
		<td>S3 key prefix for the Quick Start assets. Quick Start key prefix can include numbers, lowercase letters, uppercase letters, hyphens (-), dots(.) and forward slash (/).</td>
	</tr>
	<tr>
		<td>Lambda zips bucket name</td>
		<td>[OPTIONAL] The name of the S3 bucket where the Lambda zip files should be placed. If you leave this parameter blank, an S3 bucket will be created.</td>
	</tr>    
</table>

<table>
	<tr>
		<td colspan="2"><strong>Optional Kubernetes add-ins</strong></td>
	<tr>
		<td width="33%">Cluster autoscaler</td>
		<td width="600px">Choose Enabled to enable Kubernetes cluster autoscaler.</td>
	</tr>
	<tr>
		<td>EFS storage class</td>
		<td>Choose Enabled to enable EFS storage class, which will create the required EFS volume.</td>
	</tr>
	<tr>
		<td>EFS performance mode</td>
		<td>Choose maxIO mode to provide greater IOPS with an increased latency. Only has an effect when EfsStorageClass is enabled.</td>
	</tr>
	<tr>
		<td>EFS throughput mode</td>
		<td>Choose provisioned for throughput that is not dependent on the amount of data stored in the file system. Only has an effect when EfsStorageClass is enabled.</td>
	</tr>
	<tr>
		<td>EFS provisioned throughput in Mibps</td>
		<td>Set to 0 if EfsThroughputMode is set to bursting. Only has an effect when EfsStorageClass is enabled.</td>
	</tr>        
</table>

<strong>Specify Options</strong><br />
Generally speaking, no additional options need to be configured. If you are experiencing continued problems installing the software, disable "Rollback on failure" under the "Advanced" options. This will allow for further troubleshooting if necessary. Click on the "Next" button to continue.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/options-solodev-cms-eks.jpg" /></td>
	</tr>
</table>

<strong>Review</strong><br />
Review all CloudFront details and options. Ensure that the "I acknowledge that AWS CloudFormation might create IAM resources with custom names" checkbox is selected as well as the "I acknowledge that AWS CloudFormation might require the following capability: CAPABILITY_AUTO_EXPAND" checkbox. Click on the "Create" button to launch your stack.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/review-solodev-cms-eks.jpg" /></td>
	</tr>
</table>

## Step 3: Monitor the CloudFormation Stack Creation Process
Upon launching your CloudFormation stack, you will be able to monitor the installation logs under the "Events" tab. The CloudFormation template will launch several stacks related to your Solodev instance. If you encounter any failures during this time, please visit the <a href="https://github.com/solodev/AWS-Launch-Pad/wiki/Common-Issues">Common Issues</a> page to begin troubleshooting.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/monitor-solodev-cms-eks.jpg" /></td>
	</tr>
</table>

## Step 4: Gather Stack Outputs for Solodev DCX
If your stack builds successfully, you will see the green "CREATE_COMPLETE" message.

Click on the primary stack and view the "Outputs" tab. You will find details pertaining to the cluster's BastionIP, EKSClusterName, HelmLambdaArn, KubeConfigPath, and KubeManifestLambdaArn. Click on the "ControlPlane" stack to see details pertaining to the cluster's CADATA, ControlPlaneProvisionRoleArn, EKSEndpoint, EKSName, EksArn, and KubeConfigPath.

Save or take note of these output values as you will need them when launching Solodev DCX on the EKS cluster.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/outputs-solodev-cms-eks.jpg" /></td>
	</tr>
</table>

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/install/outputs-solodev-cms-eks-2.jpg" /></td>
	</tr>
</table>

## Step 5: Download and Configure kcmd.sh
Access and download the <a href="https://github.com/techcto/quickstart-solodev-dcx/blob/master/eks/bin/kcmd.sh">Solodev DCX custom kcmd.sh script</a>. Place the shell script inside a directory you will use to access your Kubernetes cluster.

Modify lines 8-11; the values will correspond to your stack's output.

<pre>
#GET VALUES FROM CLOUDFORMATION OUTPUT OF EKS STACK
export CAData=""
export EKSEndpoint=""
export EKSName=""
export ControlPlaneProvisionRoleArn=""
</pre>

## Step 6: Create Service Account
From command line and inside the directory that has the kcmd.sh script, run the following to generate a needed config file:
<pre>
./kcmd.sh init
</pre>

From command line and inside the directory that has the kcmd.sh script, run the following to create the needed Service Account to launch Solodev DCX:
<pre>
./kcmd.sh initServiceAccount
</pre>

Take note that this will create a Service Account with the name "solodev-serviceaccount". You will need this value as you launch Solodev DCX.

## Step 7: Launch Solodev DCX
With your EKS stack successfully launched and a service account properly configured, you can proceed to launch Solodev DCX.

<p align="center"><a href="deploy-solodev-dcx.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/solodev-launch-btn.png" width="200" /></a></p>

---
© 2019 Solodev. All rights reserved worldwide. And off planet. 

Errors or corrections? Email us at help@solodev.com.

---
Visit [solodev.com](https://www.solodev.com/) to learn more. <img src="https://www.google-analytics.com/collect?v=1&tid=UA-3849724-1&cid=1&t=event&ec=github_aws&ea=main&cs=github&cm=github&cn=github_aws" />
