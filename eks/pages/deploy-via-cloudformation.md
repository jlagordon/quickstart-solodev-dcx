<a href="#"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Solodev_Lite_Header.jpg"/></a>

# Solodev DCX Enterprise Edition for Kubernetes
Designed for enterprise-level demands, Solodev DCX Enterprise Edition for EKS gives you best-of-breed features and advanced capabilities on a secure archtiecture managed by Amazon EKS. Launch Solodev DCX in a new EKS cluster or even deploy to an existing cluster.

## Overview
Solodev DCX Enterprise Edition for Kubernetes on AWS uses a set of YAML templates to (1) optionally create a new EKS cluster, and (2) deploy Solodev DCX to an EKS cluster.

Full deployment consists of either deploying a new EKS cluster and Solodev DCX to that cluster or deploying Solodev DCX to a preexisting EKS cluster. All YAML templates are deployed via <a href="http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/Welcome.html">AWS CloudFormation</a>.

![AWS Diagram](https://raw.githubusercontent.com/solodev/aws/master/pages/images/Solodev_EKS_Architecture.jpg)

## Step 1: Subscribe on the AWS Marketplace
Solodev is a professionally managed, enterprise-class Digital Customer Experience Platform and content management system (CMS). Before launching one of our products, you'll first need to subscribe to Solodev on the <a href="https://aws.amazon.com/marketplace/pp/B07XV951M6">AWS Marketplace.</a> Click the button below to get started: 
<table>
	<tr>
		<td width="60%"><a href="https://aws.amazon.com/marketplace/pp/B07XV951M6"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/AWS_Marketplace_Logo.jpg" /></a></td>
		<td><a href="https://aws.amazon.com/marketplace/pp/B07XV951M6"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/Subscribe_Large.jpg" /></a></td>
	</tr>
</table>

Already have a Solodev license? Call <a href="tel:1.800.859.7656">1-800-859-7656</a> and we’ll activate your subscription for you.<br /><br />

## Step 2: Configure Your VPC and EC2 Key Pair
Please note that both a <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html">VPC</a> and <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html">EC2 Key Pair</a> must be configured within the region you intend to launch your stack.

While not required, <b><i>it is strongly recommended</i></b> to create a new VPC using the <a href="https://github.com/techcto/solodev-aws/blob/master/aws/corp-vpc.yaml">AWS VPC by Solodev CloudFormation Template</a>. Click the button below to launch the AWS VPC by Solodev.

<p align="center"><a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=solodev-vpc&templateURL=https://solodev-aws-ha.s3.amazonaws.com/aws/corp-vpc.yaml"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/solodev-launch-btn.png" width="200" /></a></p>

## Step 3: Launch your CloudFormation Stack(s)
Once you’ve configured your <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html">VPC</a> and <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html">EC2 Key Pair</a>, you can your CloudFormation stack(s).

Please follow the instructions below depending upon your current environment. If you do not have an existing EKS cluster, begin by launching <a href="deploy-eks.md">Amazon EKS by Solodev</a>. Once that is complete, follow the directions to deploy <a href="deploy-solodev-dcx.md">Solodev DCX for Kubernetes</a> to that newly created EKS cluster. Conversely, if you wish to deploy Solodev DCX for Kubernetes to a preexisting EKS cluster, skip directly to <a href="deploy-solodev-dcx.md">those instructions</a>.

<table>
	<tr>
		<td width="25%"><a href="deploy-eks.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/amazon-eks-by-solodev.jpg" /></a></td>
		<td>
			<h3>Amazon EKS by Solodev*</h3>
			<p>Launch Amazon Elastic Kubernets Service (EKS) in a new cluster and manage your containers at any scale with Solodev. Launch your applications rapidly and across AWS Regions and Availability Zones, and move from environment to environment regardless of operating system.</p>
			<p align="right"><a href="deploy-eks.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/solodev-launch-btn.png" width="200" /></a></p>
		</td>
	</tr>
</table>

<table>
	<tr>
		<td width="25%"><a href="deploy-solodev-dcx.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/solodev-dcx-for-eks.jpg" /></a></td>
		<td>
			<h3>Solodev DCX for Kubernetes</h3>
			<p>Deploy Solodev DCX for Kubernetes ands tart managing and scaling your websites and digital experiences on AWS. Rapidly move from your local environment to the cloud, add or remove containers to meet shifts in traffic, and manage entire fleets of Solodev applications with the power of Amazon EKS.</p>
			<p align="right"><a href="deploy-solodev-dcx.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/solodev-launch-btn.png" width="200" /></a></p>
		</td>
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

---
© 2019 Solodev. All rights reserved worldwide. And off planet. 

Errors or corrections? Email us at help@solodev.com.

---
Visit [solodev.com](https://www.solodev.com/) to learn more. <img src="https://www.google-analytics.com/collect?v=1&tid=UA-3849724-1&cid=1&t=event&ec=github_aws&ea=main&cs=github&cm=github&cn=github_aws" />
