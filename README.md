<a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Solodev_Lite_Header.jpg"/></a>

# Solodev DCX Enterprise Edition for Kubernetes
Designed for enterprise-level demands, Solodev DCX Enterprise Edition for EKS gives you best-of-breed features and advanced capabilities on a secure archtiecture managed by Amazon EKS. Launch Solodev DCX in a new EKS cluster or even deploy to an existing cluster.

## Overview
Solodev DCX Enterprise Edition for Kubernetes on AWS uses a set of YAML templates including [Amazon EKS](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html), [Linux Bastion Host](https://docs.aws.amazon.com/quickstart/latest/linux-bastion/architecture.html), [Amazon EKS Clusters](https://docs.aws.amazon.com/eks/latest/userguide/clusters.html), [AWS Identity and Access Management](https://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html), [AWS Lambda](https://docs.aws.amazon.com/lambda/latest/dg/welcome.html), [EKS Cluster Autoscaler](#), and [Amazon Elastic File System (EFS)](http://docs.aws.amazon.com/efs/latest/ug/whatisefs.html).

![AWS Diagram](https://raw.githubusercontent.com/solodev/aws/master/pages/images/Solodev_EKS_Architecture.jpg)

Getting to the Solodev Launchpad is easy. In just a few short steps, you'll be lifting off on AWS.


## Step 1: Subscribe on the AWS Marketplace

Solodev is a professionally managed, enterprise-class Digital Customer Experience Platform and content management system (CMS). Before launching one of our products, you'll first need to subscribe to Solodev on the <a href="#">AWS Marketplace.</a> Click the button below to get started: 
<table>
	<tr>
		<td width="60%"><a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images//AWS_Marketplace_Logo.jpg" /></a></td>
		<td><a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images//Subscribe_Large.jpg" /></a></td>
	</tr>
</table>

Already have a Solodev license? Call <a href="tel:1.800.859.7656">1-800-859-7656</a> and we’ll activate your subscription for you.<br /><br />

## Step 2: Configure Your VPC and EC2 Key Pair
Please note that both a <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html">VPC</a> and <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html">EC2 Key Pair</a> must be configured within the region you intend to launch your stack. If the following items are already created, you can skip directly to launch.<br/><br />

## Step 3: Launch your CloudFormation Stack
Once you’ve configured your <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html">VPC</a> and <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html">EC2 Key Pair</a>, you can launch your CloudFormation stack. Select the AWS region of your choice below:

<strong>Confirm Subscription</strong><br />
Click on the "Continue to Subscribe" link within the AWS Marketplace listing. Once your subscription is processed, you will see confirmation and the "Continue to Configuration" button.

<strong>Configure Solodev DCX</strong><br />
Specify the basic configurables such as the software version. Click on the "Continue to Launch" button to proceed.

<strong>Launch Solodev DCX</strong><br />
Confirm your configurations and Click on the "Launch Solodev CMS" link to continue to CloudFormation.

## Step 4: Fill Out the CloudFormation Stack Wizard
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

## Step 5: Monitor the CloudFormation Stack Creation Process
Upon launching your CloudFormation stack, you will be able to monitor the installation logs under the "Events" tab. The CloudFormation template will launch several stacks related to your Solodev instance. If you encounter any failures during this time, please visit the <a href="https://github.com/solodev/AWS-Launch-Pad/wiki/Common-Issues">Common Issues</a> page to begin troubleshooting.

<table>
	<tr>
		<td><img src="https://raw.githubusercontent.com/solodev/AWS-Launch-Pad/master/pages/images/install/monitor-solodev-cms-eks.jpg" /></td>
	</tr>
</table>

## Support
Houston, we have no problems… because Solodev Customer Care has your back at every step! From our world-class HelpDesk to our focused training sessions, you’ve got the best team on the ground to get you to the stars. 

Solodev Customer Care Includes
* 24x7x365 U.S. based human support
* Online HelpDesk ticketing
* Phone and email support
* Live training courses
* Over 300 pages of searchable documentation and tutorials

To learn more about our add-on support options, call 1-800-859-7656 to speak with one of our Solodev Customer Care Specialists.

<a href="https://www.solodev.com/product/support.stml"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Solodev_Git_Support.jpg"/></a>

## Need Help?

Solodev is a professionally managed, enterprise-class solution, and our team of certified engineers are here to support your success. While our self-serve options are easy to launch, you’ve always got a co-pilot at the helm. If you have any questions – or if you already have a Solodev license and need support with your AWS subscription – call <a href="tel:1.800.859.7656">1-800-859-7656</a> and we’ll help you get to the launchpad.


© 2019 Solodev. All rights reserved worldwide. And off planet. 

Errors or corrections? Email us at help@solodev.com.

---
Visit [solodev.com](https://www.solodev.com/) to learn more. <img src="https://www.google-analytics.com/collect?v=1&tid=UA-3849724-1&cid=1&t=event&ec=github_aws&ea=main&cs=github&cm=github&cn=github_aws" />
