resource "null_resource" "wait_instance" {
  depends_on = [cloudstack_instance.vm01]
  provisioner "remote-exec" {
    #inline = [
    #  "sudo dnf module enable -y python39",
    #  "sudo dnf install -y python3.9"
    #]
    connection {
      host        = cloudstack_ipaddress.vm01_ip.ip_address
      user        = "root"
      private_key = file("~/.ssh/id_ed25519")
    }
    inline = ["echo 'ready to do ansible!'"]
  }
}

resource "local_file" "inventory" {
  depends_on = [null_resource.wait_instance]
  
  content = <<EOT
[servers]
${cloudstack_ipaddress.vm01_ip.ip_address} ansible_ssh_user=root ansible_ssh_private_key_file=~/.ssh/id_ed25519
EOT

  filename = "../ansible_roles/inventory"
}

resource "local_file" "add_server_to_vars" {
  depends_on = [null_resource.wait_instance]

  content = <<EOT
server_hostname: ${cloudstack_instance.vm01.name}
EOT

  filename = "../ansible_roles/vars/servers.yml"
}

resource "ansible_playbook" "setup_server" {
  depends_on              = [null_resource.wait_instance]
  playbook                = "../ansible_roles/setup_server.yml"
  name                    = "vm01"
  replayable              = false
  ignore_playbook_failure = true
  extra_vars = {
    ansible_host                 = cloudstack_ipaddress.vm01_ip.ip_address
    ansible_user                 = "root"
    ansible_ssh_private_key_file = "~/.ssh/id_ed25519"
    ansible_ssh_common_args      = "-o StrictHostKeyChecking=no"
  }
}

output "playbook_stdout" {
  value = ansible_playbook.setup_server.ansible_playbook_stdout
}

output "playbook_stderr" {
  value = ansible_playbook.setup_server.ansible_playbook_stderr
}
