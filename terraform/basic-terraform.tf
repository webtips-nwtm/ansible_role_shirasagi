resource "cloudstack_ipaddress" "vm01_ip" {
  zone = "Basic_tky003"
}
resource "cloudstack_instance" "vm01" {
  name             = "ss-suginami"
  display_name     = "ss-suginami"
  zone             = "Basic_tky003"
  service_offering = "m1.large"
  security_group_names = ["srsg"]
  template         = "almalinux9-base"
  expunge          = true
}

resource "cloudstack_static_nat" "vm01_nat" {
  ip_address_id    = cloudstack_ipaddress.vm01_ip.id
  virtual_machine_id = cloudstack_instance.vm01.id
}

resource "cloudstack_disk" "datadisk01" {
  name             = "ss-suginami-datadisk01"
  disk_offering    = "51b2caac-cfda-44e2-8212-ff424ab112a7"
  size             = 80
  attach           = true
  virtual_machine_id  = "${cloudstack_instance.vm01.id}"
  zone             = "${cloudstack_instance.vm01.zone}"
}
