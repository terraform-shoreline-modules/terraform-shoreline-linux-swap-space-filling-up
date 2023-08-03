resource "shoreline_notebook" "swap_space_filling_up" {
  name       = "swap_space_filling_up"
  data       = file("${path.module}/data/swap_space_filling_up.json")
  depends_on = [shoreline_action.invoke_swapon_info,shoreline_action.invoke_out_of_memory_logs,shoreline_action.invoke_disable_swap]
}

resource "shoreline_file" "swapon_info" {
  name             = "swapon_info"
  input_file       = "${path.module}/data/swapon_info.sh"
  md5              = filemd5("${path.module}/data/swapon_info.sh")
  description      = "Check which processes are using swap space on the affected host"
  destination_path = "/agent/scripts/swapon_info.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "out_of_memory_logs" {
  name             = "out_of_memory_logs"
  input_file       = "${path.module}/data/out_of_memory_logs.sh"
  md5              = filemd5("${path.module}/data/out_of_memory_logs.sh")
  description      = "Check system logs for any indications of swap space issues"
  destination_path = "/agent/scripts/out_of_memory_logs.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "disable_swap" {
  name             = "disable_swap"
  input_file       = "${path.module}/data/disable_swap.sh"
  md5              = filemd5("${path.module}/data/disable_swap.sh")
  description      = "Turning off all swap spaces and removing swap entries"
  destination_path = "/agent/scripts/disable_swap.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_swapon_info" {
  name        = "invoke_swapon_info"
  description = "Check which processes are using swap space on the affected host"
  command     = "`chmod +x /agent/scripts/swapon_info.sh && /agent/scripts/swapon_info.sh`"
  params      = []
  file_deps   = ["swapon_info"]
  enabled     = true
  depends_on  = [shoreline_file.swapon_info]
}

resource "shoreline_action" "invoke_out_of_memory_logs" {
  name        = "invoke_out_of_memory_logs"
  description = "Check system logs for any indications of swap space issues"
  command     = "`chmod +x /agent/scripts/out_of_memory_logs.sh && /agent/scripts/out_of_memory_logs.sh`"
  params      = []
  file_deps   = ["out_of_memory_logs"]
  enabled     = true
  depends_on  = [shoreline_file.out_of_memory_logs]
}

resource "shoreline_action" "invoke_disable_swap" {
  name        = "invoke_disable_swap"
  description = "Turning off all swap spaces and removing swap entries"
  command     = "`chmod +x /agent/scripts/disable_swap.sh && /agent/scripts/disable_swap.sh`"
  params      = []
  file_deps   = ["disable_swap"]
  enabled     = true
  depends_on  = [shoreline_file.disable_swap]
}

