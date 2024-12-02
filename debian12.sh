wget https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-generic-amd64.qcow2

virt-customize -a debian-12-generic-amd64.qcow2 --install qemu-guest-agent --update --truncate /etc/machine-id

qm create 1000 --name "debian12" --memory 2048 --net0 virtio,bridge=vmbr0 --agent enabled=1 --cpu host

qm importdisk 1000 debian-12-generic-amd64.qcow2 local-lvm -format qcow2

qm set 1000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-1000-disk-0

qm resize 1000 scsi0 10G

qm set 1000 --ide2 local-lvm:cloudinit

qm set 1000 --boot c --bootdisk scsi0 --serial0 socket --vga serial0

qm template 1000

rm debian-12-generic-amd64.qcow2