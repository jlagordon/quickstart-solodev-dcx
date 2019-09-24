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

While not required, <b><i>it is strongly recommended</i></b> to create a new VPC using the <a href="https://github.com/techcto/solodev-aws/blob/master/aws/corp-vpc.yaml">AWS VPC by Solodev</a>. Click the button below to launch the AWS VPC by Solodev.

<p align="center"><a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=solodev-vpc&templateURL=https://solodev-aws-ha.s3.amazonaws.com/aws/corp-vpc.yaml"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/launch-btn2.png" /></a></a>

## Step 3: Launch AWS EKS by Solodev
Once you’ve configured your <a href="http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_Introduction.html">VPC</a> and <a href="http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html">EC2 Key Pair</a>, you can launch AWS EKS by Solodev.

<p align="center"><a href="pages/deploy-eks.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/launch-btn2.png" /></a></p>

<pre>* Developer? Please see instructions regarding setting up a <a href="pages/deploy-solodev-dcx-network.md">Solodev DCX Network</a> for your EKS cluster.</pre>

## Step 4: Launch Solodev DCX
With an EKS cluster running, you can deploy Solodev DCX.

<p align="center"><a href="pages/deploy-solodev-dcx.md"><img src="https://raw.githubusercontent.com/solodev/aws/master/pages/images/launch-btn.png" /></a></p>

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
