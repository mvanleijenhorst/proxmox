wget https://cloud-images.ubuntu.com/minimal/releases/noble/release/ubuntu-24.04-minimal-cloudimg-amd64.img

virt-customize -a ubuntu-24.04-minimal-cloudimg-amd64.img --install qemu-guest-agent

mv ubuntu-24.04-minimal-cloudimg-amd64.img ubuntu-24.04-minimal-cloudimg.qcow2

qm create 9000 --name "ubuntu-24.04-minimal-cloudinit-template" --memory 1024 --cores 1 --net0 virtio,bridge=vmbr0
qm importdisk 9000 ubuntu-24.04-minimal-cloudimg.qcow2 local_storage
qm set 9000 --scsihw virtio-scsi-pci --scsi0 local_storage:9000/vm-9000-disk-0.raw
qm set 9000 --boot c --bootdisk scsi0
qm set 9000 --ide2 local_storage:cloudinit
qm set 9000 --serial0 socket --vga serial0
qm set 9000 --agent enabled=1
