#generate name based on the convention
locals {
  naming_convention_info = {
    for key, value in var.naming_convention_info : "${key}" => {
      name_info = merge(value.name_info, {
        "res_type" = var.resource_type
      })
      tags = lookup(value, local.metadata_tag_name, {})
    }
  }

  arr_name_format = split("|", var.name_format)
  has_count       = contains(local.arr_name_format, "instance")


  # tuple<name,instance_count,key,tags>
  tuple_name_count_key = [for key, value in local.naming_convention_info : {
    name                           = join("", [for name in local.arr_name_format : lookup(value.name_info, name, name)])
    count                          = lookup(value.name_info, local.metadata_instance_count, 1) <= 0 ? 1 : lookup(value.name_info, local.metadata_instance_count, 1)
    "${local.metadata_parent_key}" = key
    local_tag_values               = [for ktag, vtag in local.tag_info : lookup(value.name_info, vtag.nameinfo_key, vtag.default)]
    tags                           = value.tags
    start_index                    = lookup(value.name_info, "start_index", 1)

  }]

  # Outputs a map  -> { subnet_1 = { name: [], tags = {} }, subnet_2 = { name: [], tags : {} } } 
  # key array and tuple_naming_convention_info are zip mapped 
  tuple_naming_convention_info = [for key, value in local.tuple_name_count_key : {
    names = local.has_count ? [for cnt in range(value.count) : replace(value.name, "instance", format("%03d", cnt + value.start_index))] : [value.name]
    tags  = merge(value.tags, zipmap(keys(local.tag_info), value.local_tag_values))
  }]

  tuple_tags_naming_convention_info = [for key, value in local.tuple_naming_convention_info : {
    names = value.names
    tags  = [for name in value.names : merge(value.tags, { Name = name })]
  }]

  keys         = [for key, value in var.naming_convention_info : key]
  name_info_op = zipmap(local.keys, local.tuple_tags_naming_convention_info)
}
