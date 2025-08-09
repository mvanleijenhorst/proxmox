wget https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img

virt-customize -a ubuntu-24.04-server-cloudimg-amd64.img --install qemu-guest-agent

mv ubuntu-24.04-server-cloudimg-amd64.img ubuntu-24.04-server-cloudimg.qcow2

qm create 9999 --name "ubuntu-24.04-server-cloudinit-template" --memory 1024 --cores 1 --net0 virtio,bridge=vmbr0
qm importdisk 9999 ubuntu-24.04-server-cloudimg.qcow2 local_storage
qm set 9999 --scsihw virtio-scsi-pci --scsi0 local_storage:9999/vm-9999-disk-0.raw
qm set 9999 --boot c --bootdisk scsi0
qm set 9999 --ide2 local_storage:cloudinit
qm set 9999 --serial0 socket --vga serial0
qm set 9999 --agent enabled=1
