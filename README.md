
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Swap Space filling Up
---

A swap space issue in Linux occurs when the system's usage of swap space becomes problematic or inefficient. while swap space is valuable for handling occasional memory demands, over-reliance on it can indicate underlying performance issues. Understanding swap usage patterns and tuning the system accordingly can help avoid swap space problems and improve overall system performance.

### Parameters
```shell
export HOST_NAME="PLACEHOLDER"
```

## Debug

### Check swap usage on the affected host
```shell
free -m
```

### Check which processes are using swap space on the affected host
```shell
sudo swapon -s

sudo swapon --show=NAME,SIZE,USED,PRIO
```

### Check system logs for any indications of swap space issues
```shell
sudo journalctl -k | grep "Out of memory"

sudo dmesg | grep "Out of memory"
```

### Check disk space usage on the affected host
```shell
df -h
```

### Check if any processes are consuming high CPU or memory resources
```shell
top
```

### Turning off all swap spaces and removing swap entries
```shell
#!/bin/bash



# Check if swap is enabled

if [ "$(swapon --show | wc -l)" -gt 0 ]; then

  echo "Swap is currently enabled. Disabling swap..."

  

  # Turn off all swap devices

  sudo swapoff -a

  

  # Remove swap entries from /etc/fstab

  sudo sed -i '/swap/d' /etc/fstab

  

  echo "Swap is disabled."

else

  echo "Swap is already disabled."

fi
```