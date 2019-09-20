# Deploy EKS Cluster

## Step 1: Launch your CloudFormation Stack
<table>
	<tr>
		<th width="882"><a href="#">Launch a New EKS Cluster<br /><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/launch-btn2.png" /></a></th>
	</tr>
</table>

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
		<td width="33%">Number of nodes</td>
		<td width="600px">The number of Amazon EKS node instances. The default is one for each of the three Availability Zones.</td>
	</tr> 
	<tr>
		<td width="33%">Node group name</td>
		<td width="600px">The name for EKS node group.</td>
	</tr>
	<tr>
		<td width="33%">Node volume size</td>
		<td width="600px">The size for the node's root EBS volumes.</td>
	</tr>
	<tr>
		<td width="33%">Additional EKS admin ARNs</td>
		<td width="600px">[OPTIONAL] Comma separated list of IAM user/role Amazon Resource Names (ARNs) to be granted admin access to the EKS cluster</td>
	</tr>
	<tr>
		<td width="33%">Kubernetes version</td>
		<td width="600px">The Kubernetes control plane version.</td>
	</tr>          
</table>

<table>
	<tr>
		<td colspan="2"><strong>Optional Solodev DCX configuration</strong></td>
	<tr>
		<td width="33%">Solodev DCX Network</td>
		<td width="600px">Choose Enabled to enable the Solodev DCX Network</td>
	</tr>
	<tr>
		<td width="33%">ZoneName</td>
		<td width="600px"></td>
	</tr>
	<tr>
		<td width="33%">ZoneId</td>
		<td width="600px"></td>
	</tr>
	<tr>
		<td width="33%">Solodev DCX</td>
		<td width="600px">Choose Enabled to install Solodev DCX</td>
	</tr>
	<tr>
		<td width="33%">AdminPassword</td>
		<td width="600px">The solodev admin password</td>
	</tr>
	<tr>
		<td width="33%">DatabasePassword</td>
		<td width="600px">The database root password</td>
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
		<td width="33%">Quick Start S3 key prefix</td>
		<td width="600px">S3 key prefix for the Quick Start assets. Quick Start key prefix can include numbers, lowercase letters, uppercase letters, hyphens (-), dots(.) and forward slash (/).</td>
	</tr>
	<tr>
		<td width="33%">Lambda zips bucket name</td>
		<td width="600px">[OPTIONAL] The name of the S3 bucket where the Lambda zip files should be placed. If you leave this parameter blank, an S3 bucket will be created.</td>
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
		<td width="33%">EFS storage class</td>
		<td width="600px">Choose Enabled to enable EFS storage class, which will create the required EFS volume.</td>
	</tr>
	<tr>
		<td width="33%">EFS performance mode</td>
		<td width="600px">Choose maxIO mode to provide greater IOPS with an increased latency. Only has an effect when EfsStorageClass is enabled.</td>
	</tr>
	<tr>
		<td width="33%">EFS throughput mode</td>
		<td width="600px">Choose provisioned for throughput that is not dependent on the amount of data stored in the file system. Only has an effect when EfsStorageClass is enabled.</td>
	</tr>
	<tr>
		<td width="33%">EFS provisioned throughput in Mibps</td>
		<td width="600px">Set to 0 if EfsThroughputMode is set to bursting. Only has an effect when EfsStorageClass is enabled.</td>
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

© 2019 Solodev. All rights reserved worldwide. And off planet. 

Errors or corrections? Email us at help@solodev.com.

---
Visit [solodev.com](https://www.solodev.com/) to learn more. <img src="https://www.google-analytics.com/collect?v=1&tid=UA-3849724-1&cid=1&t=event&ec=github_aws&ea=main&cs=github&cm=github&cn=github_aws" />