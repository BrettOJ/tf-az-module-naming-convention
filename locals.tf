#metadata keys 
locals {
  metadata_parent_key     = "parent_key"
  metadata_delimeter      = "delimeter"
  metadata_tag_name       = "tags"
  metadata_instance_index = "instance_index"
  metadata_instance_count = "instance_count"
}


#convention enforced in the module
locals {
 
  convention = {
    type  = "name"
    max   = 8
    min   = 8
    trail = "0"
    fmt   = "%s"
  }
  order = ["res_type", "project_code", "env", "zone", "tier", "name"]

  tag_info = {
    "Resource-Name" = {
      nameinfo_key = "res_type"
      default      = ""
    }
    "Agency-Code" = {
      nameinfo_key = "agency_code"
      default      = "ava"
    }
    "Project-Code" = {
      nameinfo_key = "project_code"
      default      = "prj"
    }
    "Environment" = {
      nameinfo_key = "env"
      default      = "dev"
    }
    "Zone" = {
      nameinfo_key = "zone"
      default      = ""
    }
    "Tier" = {
      nameinfo_key = "tier"
      default      = ""
    }
    "Name" = {
      nameinfo_key = "name"
      default      = ""
    }
    "Created-By" = {
      nameinfo_key = "CreatedBy"
      default      = "terraform"
    }
  }
}