#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit

TEMPLATE_DIR=${TEMPLATE_DIR:-/tmp/worker}

sudo mv $TEMPLATE_DIR/kubelet.service /etc/systemd/system/kubelet.service
sudo chown root:root /etc/systemd/system/kubelet.service

sudo systemctl daemon-reload
# Disable the kubelet until the proper dropins have been configured
sudo systemctl disable kubelet

################################################################################
### EKS ########################################################################
################################################################################

# #iscsi
# sudo yum -y install iscsi-initiator-utils
# sudo systemctl enable iscsid
# sudo systemctl start iscsid

################################################################################
### Weave ########################################################################
################################################################################
# sudo mkdir -p /opt/cni/bin
# sudo mkdir -p /etc/cni/net.d
# sudo curl -L git.io/weave -o /usr/local/bin/weave
# sudo chmod a+x /usr/local/bin/weave
# sudo /usr/local/bin/weave setup

sudo mkdir -p /etc/eks
sudo touch /etc/eks/solodev.txt
sudo mv $TEMPLATE_DIR/bootstrap.sh /etc/eks/bootstrap.sh
sudo chmod +x /etc/eks/bootstrap.sh