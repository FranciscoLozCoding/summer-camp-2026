# waggle-sensor GitHub org index (public repos)

Scraped from [github.com/orgs/waggle-sensor/repositories](https://github.com/orgs/waggle-sensor/repositories?type=public) on **2026-07-14**.

**Scope:** public repositories only (private repos skipped). Forks are included and marked.

## How to use this file

1. Find the repo by name or skim category summaries below.
2. Open the **URL** (clone / browse README / issues) when you need source or examples — do not invent APIs from the summary alone.
3. Prefer camp skill refs + [sage-docs-index.md](sage-docs-index.md) for conceptual/docs answers; use this index when you need **code**.
4. High-signal repos:
   - SDK: [pywaggle](https://github.com/waggle-sensor/pywaggle)
   - `pluginctl` / `sesctl`: [edge-scheduler](https://github.com/waggle-sensor/edge-scheduler)
   - On-node services: [waggle-edge-stack](https://github.com/waggle-sensor/waggle-edge-stack)
   - MCP: [sage-mcp](https://github.com/waggle-sensor/sage-mcp)
   - Website/docs source: [sage-website](https://github.com/waggle-sensor/sage-website)

**Public repos indexed:** 220

## Core platform — WES, Beehive, Beekeeper, nodes (82)

### app-init-shim _Go_

- **URL:** https://github.com/waggle-sensor/app-init-shim
- **Summary:** Provides basic app init container shim.

### app-meta-cache _Go_

- **URL:** https://github.com/waggle-sensor/app-meta-cache
- **Summary:** A Docker container for managing meta information of Waggle plugins

### attach-to-node-k3s _Go_

- **URL:** https://github.com/waggle-sensor/attach-to-node-k3s
- **Summary:** Tool for remotely debugging nodes.

### beehive-data-api _Go_

- **URL:** https://github.com/waggle-sensor/beehive-data-api
- **Summary:** Beehive Data API Service
- **Topics:** beehive

### beehive-data-exporter _Python_

- **URL:** https://github.com/waggle-sensor/beehive-data-exporter
- **Summary:** Tools for exporting data files from Beehive.
- **Topics:** beehive

### beehive-etl _Python_

- **URL:** https://github.com/waggle-sensor/beehive-etl
- **Summary:** Beehive ETL code and tools

### beehive-influxdb-backup _Shell_

- **URL:** https://github.com/waggle-sensor/beehive-influxdb-backup
- **Summary:** Tools for performing native backup of Beehive's InfluxDB server.
- **Topics:** beehive

### beehive-influxdb-loader _Python_

- **URL:** https://github.com/waggle-sensor/beehive-influxdb-loader
- **Summary:** Beehive InfluxDB Data Loader Service
- **Topics:** beehive

### beehive-nodes-service _Go_

- **URL:** https://github.com/waggle-sensor/beehive-nodes-service
- **Summary:** Service that updates beehive component about new nodes
- **Topics:** beehive, beekeeper

### beehive-upload-server _Shell_

- **URL:** https://github.com/waggle-sensor/beehive-upload-server
- **Summary:** ssh+rsync based upload server for training data.
- **Topics:** beehive

### beekeeper _Python_

- **URL:** https://github.com/waggle-sensor/beekeeper
- **Summary:** Management and administrative cloud services for Waggle.
- **Topics:** cloud, beekeeper

### beekeeper-key-tools _Shell_

- **URL:** https://github.com/waggle-sensor/beekeeper-key-tools
- **Summary:** Houses the tools to create the beekeeper certificate authority keys, node registration keys, etc.

### beekeeper-netman-connectivity _Go_

- **URL:** https://github.com/waggle-sensor/beekeeper-netman-connectivity
- **Summary:** NetworkManager Connectivity check service
- **Topics:** beekeeper

### blade-image _Shell_

- **URL:** https://github.com/waggle-sensor/blade-image
- **Summary:** Blade-Image
- **Topics:** node, blade

### core _Python_

- **URL:** https://github.com/waggle-sensor/core
- **Summary:** Core software shared by both the Node Controller (NC) and Edge Processor (EP)

### data-repository

- **URL:** https://github.com/waggle-sensor/data-repository
- **Summary:** Waggle Data Repository
- **Topics:** docs, beehive

### edge-code-repository

- **URL:** https://github.com/waggle-sensor/edge-code-repository
- **Summary:** Edge Code Repository
- **Topics:** docs, beehive

### edge-scheduler _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/edge-scheduler
- **Summary:** Waggle Edge Scheduler
- **Topics:** docs, beehive

### edge-scheduler-monitor

- **URL:** https://github.com/waggle-sensor/edge-scheduler-monitor
- **Summary:** A backend service to monitor activities in cloud/edge schedulers.

### edgeprocessor

- **URL:** https://github.com/waggle-sensor/edgeprocessor
- **Summary:** Edge Processor

### file-forager _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/file-forager
- **Summary:** Runs on Waggle node to sync locale files to the Beehive file storage. The plugin manages its state locally due to the inability to query Beehive for synced fil…

### gpu-stress-test _Python_

- **URL:** https://github.com/waggle-sensor/gpu-stress-test
- **Summary:** Small GPU / CUDA stress bundle as a Docker image

### grafana-agent-loader _Go_

- **URL:** https://github.com/waggle-sensor/grafana-agent-loader
- **Summary:** Prometheus metrics loader to InfluxDB

### honeycomb _Python_

- **URL:** https://github.com/waggle-sensor/honeycomb
- **Summary:** Modular Peripheral configuration manager
- **Topics:** docs, node

### jetson-exporter _Go_

- **URL:** https://github.com/waggle-sensor/jetson-exporter
- **Summary:** A metrics provider for Jeton GPU

### jobctl _Python_

- **URL:** https://github.com/waggle-sensor/jobctl
- **Summary:** A Python package for controlling job submission and management on Waggle edge nodes using sesctl.

### k3s-test

- **URL:** https://github.com/waggle-sensor/k3s-test
- **Summary:** Some scripts and things to help test k3s.

### lambda-triggers

- **URL:** https://github.com/waggle-sensor/lambda-triggers
- **Summary:** Lambda Triggers
- **Topics:** docs, beehive

### media-streamer _Shell_

- **URL:** https://github.com/waggle-sensor/media-streamer
- **Summary:** A ffmpeg based streaming server over HTTP

### minimal-k3s-vagrantbox

- **URL:** https://github.com/waggle-sensor/minimal-k3s-vagrantbox
- **Summary:** Minimal Vagrantbox for experimenting with k3s.

### node-health-reporter _Python_

- **URL:** https://github.com/waggle-sensor/node-health-reporter
- **Summary:** Cronjob for check and reporting node status.

### node-platforms _Shell_

- **URL:** https://github.com/waggle-sensor/node-platforms
- **Summary:** Instructions for bootstrapping a Waggle node

### nodecontroller

- **URL:** https://github.com/waggle-sensor/nodecontroller
- **Summary:** Node Controller
- **Topics:** docs, node, wildnode

### nvidia_toolchain

- **URL:** https://github.com/waggle-sensor/nvidia_toolchain
- **Summary:** Contains the NVidia ARM64 build toolchain archive for use in building kernel & CBoot
- **Topics:** node, wildsage

### perf-mon _Jinja_

- **URL:** https://github.com/waggle-sensor/perf-mon
- **Summary:** A performance monitoring toolset for applications and edge systems

### prometheus-cadvisor-proxy _Go_

- **URL:** https://github.com/waggle-sensor/prometheus-cadvisor-proxy
- **Summary:** Prometheus cadvisor proxy (for nodes)

### pywaggle _Python_

- **URL:** https://github.com/waggle-sensor/pywaggle
- **Summary:** Python SDK for integrating plugins with Waggle.
- **Topics:** audio, python, vision, waggle, waggle-edge-stack

### pywagglemsg _Python_

- **URL:** https://github.com/waggle-sensor/pywagglemsg
- **Summary:** Python module for handling Waggle messages.
- **Topics:** waggle-edge-stack

### sage-mcp _Python_

- **URL:** https://github.com/waggle-sensor/sage-mcp
- **Summary:** Sage MCP Server

### stressme _Python_

- **URL:** https://github.com/waggle-sensor/stressme
- **Summary:** A set of programs to stress a computing device on Linux, particularly on Nvidia Jetson

### virtual-waggle _Python_

- **URL:** https://github.com/waggle-sensor/virtual-waggle
- **Summary:** Virtual Waggle is a set of software tools to help build and test code for the edge.

### waggle-beehive-v2 _Python_

- **URL:** https://github.com/waggle-sensor/waggle-beehive-v2
- **Summary:** Data and processing cloud services for Waggle.
- **Topics:** cloud, beehive

### waggle-bk-registration _Python_

- **URL:** https://github.com/waggle-sensor/waggle-bk-registration
- **Summary:** Services that run on end-points to handle the registration process with the beekeeper
- **Topics:** node, deb, beekeeper, wildnode

### waggle-bk-reverse-tunnel _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-bk-reverse-tunnel
- **Summary:** Creates reverse ssh tunnel to beekeeper
- **Topics:** node, deb, blade, beekeeper, wildnode

### waggle-blade

- **URL:** https://github.com/waggle-sensor/waggle-blade
- **Summary:** Waggle Blades are standard, commercially available blade servers with x86-64 CPUS and NVIDIA GPUs for AI@Edge compute jobs.
- **Topics:** docs, node, blade

### waggle-common-tools _Python_

- **URL:** https://github.com/waggle-sensor/waggle-common-tools
- **Summary:** Common tools for Sage OS administration and operations.
- **Topics:** node, deb, blade, wildnode

### waggle-deb-builder _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-deb-builder
- **Summary:** Container for building repo deb packages.
- **Topics:** deb

### waggle-edge-stack _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-edge-stack
- **Summary:** The Waggle Edge Stack provides the core services which support running AI@Edge.
- **Topics:** node, waggle-edge-stack

### waggle-firewall _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-firewall
- **Summary:** Network firewall service
- **Topics:** node, deb, blade, wildnode

### waggle-internet-share _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-internet-share
- **Summary:** Service to share internet over local 10.31.81.1/24 network
- **Topics:** node, deb, blade, wildnode

### waggle-node-hostname _Python_

- **URL:** https://github.com/waggle-sensor/waggle-node-hostname
- **Summary:** Service run on the nodes on first boot to set the hostname [DEPRECATED]
- **Topics:** node, deb, blade, wildnode

### waggle-nodeid _Python_

- **URL:** https://github.com/waggle-sensor/waggle-nodeid
- **Summary:** Early running service in nodes to create the unique node ID used by other services.
- **Topics:** node, deb, blade, wildnode

### waggle-nodes _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-nodes
- **Summary:** All waggle-node instances are tracked here.

### waggle-powercycle _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-powercycle
- **Summary:** Tools to gracefully shutdown / reboot a Wild Waggle Node
- **Topics:** node, deb, wildnode

### waggle-rpi-pxeboot _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-rpi-pxeboot
- **Summary:** Build's a Debian package to allow NX Boards to PxeBoot an Rpi4 and configures a DHCP server
- **Topics:** raspberry-pi, node, deb, wildnode

### waggle-rpi-sd-flash _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-rpi-sd-flash
- **Summary:** Instructions for Building an SD Card *.img for flashing the RPI to a PxE-bootable state
- **Topics:** raspberry-pi, docs, factory, wildnode

### waggle-stress _Dockerfile_

- **URL:** https://github.com/waggle-sensor/waggle-stress
- **Summary:** A Docker container with tools for stressing Waggle node

### waggle-upload-sync _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-upload-sync
- **Summary:** Service to sync the data upload folder to an external drive
- **Topics:** node, deb, blade, wildnode

### waggle-wagman-watchdog _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-wagman-watchdog
- **Summary:** Wild Node Wagman Watchdog Service
- **Topics:** node, deb, wildnode, wagman

### waggle-wan-tunnel _Python_

- **URL:** https://github.com/waggle-sensor/waggle-wan-tunnel
- **Summary:** Service which manages WAN tunnel through Beekeeper.
- **Topics:** node, deb, blade, wildnode

### waggle_image _Python_

- **URL:** https://github.com/waggle-sensor/waggle_image
- **Summary:** Scripts to create waggle disk images

### wagman _C++_

- **URL:** https://github.com/waggle-sensor/wagman
- **Summary:** The Waggle Manager (Wagman), a custom circuit board and control system for Wild Waggle Nodes
- **Topics:** docs, node, wildnode

### wes-audio-server _Dockerfile_

- **URL:** https://github.com/waggle-sensor/wes-audio-server
- **Summary:** PulseAudio based server to provide audio data over the local network.
- **Topics:** node

### wes-camera-provisioner _Python_

- **URL:** https://github.com/waggle-sensor/wes-camera-provisioner
- **Summary:** WES-Camera-Provisioner
- **Topics:** waggle-edge-stack

### wes-chirpstack-server _Dockerfile_

- **URL:** https://github.com/waggle-sensor/wes-chirpstack-server
- **Summary:** WES customized implementation of the chirpstack server
- **Topics:** lorawan, waggle-edge-stack

### wes-chirpstack-tracker _Python_

- **URL:** https://github.com/waggle-sensor/wes-chirpstack-tracker
- **Summary:** Tracks chirpstack records such as devices and keys
- **Topics:** lorawan, waggle-edge-stack

### wes-data-sharing-service _Python_

- **URL:** https://github.com/waggle-sensor/wes-data-sharing-service
- **Summary:** Node data sharing service
- **Topics:** waggle-edge-stack

### wes-device-labeler _Python_

- **URL:** https://github.com/waggle-sensor/wes-device-labeler
- **Summary:** WES service which scan devices and updates labels on host node.
- **Topics:** waggle-edge-stack

### wes-factory _Python_

- **URL:** https://github.com/waggle-sensor/wes-factory
- **Summary:** Specialized WES application to be run in the factory when configuring the Wild Sage Node
- **Topics:** factory, waggle-edge-stack, wildnode

### wes-gps-server _Dockerfile_

- **URL:** https://github.com/waggle-sensor/wes-gps-server
- **Summary:** GPS server to provide GPS data over kubernetes network
- **Topics:** waggle-edge-stack

### wes-lorawan-device-templates _fork, JavaScript_

- **URL:** https://github.com/waggle-sensor/wes-lorawan-device-templates
- **Summary:** Device Template Repository for LoRaWAN devices

### wes-metrics-agent _Python_

- **URL:** https://github.com/waggle-sensor/wes-metrics-agent
- **Summary:** Metrics agent which collects metrics across devices on WES.
- **Topics:** waggle-edge-stack

### wes-playback-server _Go_

- **URL:** https://github.com/waggle-sensor/wes-playback-server
- **Summary:** Mock-up of simple playback server. Serves static files over HTTP interface.
- **Topics:** waggle-edge-stack

### wes-sftp-server _Shell_

- **URL:** https://github.com/waggle-sensor/wes-sftp-server
- **Summary:** Prototype SFTP server isolated to a container.

### wes-updater

- **URL:** https://github.com/waggle-sensor/wes-updater
- **Summary:** WES service responsible for updating all the WES services on a node
- **Topics:** waggle-edge-stack

### wes-upload-agent _Shell_

- **URL:** https://github.com/waggle-sensor/wes-upload-agent
- **Summary:** Agent which runs on the nodes to move training data to beehive.
- **Topics:** waggle-edge-stack

### wglctl _Go_

- **URL:** https://github.com/waggle-sensor/wglctl
- **Summary:** Prototype of a cli for controlling waggle

### wild-waggle-node

- **URL:** https://github.com/waggle-sensor/wild-waggle-node
- **Summary:** Wild Waggle Nodes are weatherized for remote, outdoor deployment in remote and hard-to-reach locations.
- **Topics:** docs, node, wildnode

### wildnode-cboot _C_

- **URL:** https://github.com/waggle-sensor/wildnode-cboot
- **Summary:** Wild Waggle Node NVidia Jetson Xavier NX CBoot Source.
- **Topics:** node, wildnode

### wildnode-image _Shell_

- **URL:** https://github.com/waggle-sensor/wildnode-image
- **Summary:** Open source code to build the base Wild Waggle Node OS image
- **Topics:** node, wildnode

### wildnode-kernel-releases

- **URL:** https://github.com/waggle-sensor/wildnode-kernel-releases
- **Summary:** Public Releases for Wild Waggle Node NVidia / CTI L4T BSP Source
- **Topics:** node, wildnode

### wildnode-switch-config

- **URL:** https://github.com/waggle-sensor/wildnode-switch-config
- **Summary:** Contains configuration files and firmware used when provisioning the Wild Waggle Node Unifi network switch

## ECR, scheduling helpers & science rules (5)

### ecr-docker-registry-auth _Go_

- **URL:** https://github.com/waggle-sensor/ecr-docker-registry-auth
- **Summary:** Sage auth backend for Docker Registry v2

### ecr-jenkins _Dockerfile_

- **URL:** https://github.com/waggle-sensor/ecr-jenkins
- **Summary:** Jenkins with additional tools and plugins needed to support ECR CI pipeline.

### edge-plugins _Python_

- **URL:** https://github.com/waggle-sensor/edge-plugins
- **Summary:** Waggle edge node plugins for collecting and analyzing sensor data

### sage-ecr _Python_

- **URL:** https://github.com/waggle-sensor/sage-ecr
- **Summary:** SAGE Edge Code Repository

### sciencerule-checker _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/sciencerule-checker
- **Summary:** Sciencerule Checker

## Plugin / edge app templates & hellos (8)

### cookiecutter-HuggingFace-DatasetLoadingScript _Python_

- **URL:** https://github.com/waggle-sensor/cookiecutter-HuggingFace-DatasetLoadingScript
- **Summary:** A cookie cutter template that generates a starting dataset loading script to use in HuggingFace

### cookiecutter-sage-app _Python_

- **URL:** https://github.com/waggle-sensor/cookiecutter-sage-app
- **Summary:** A cookiecutter template for starting a Sage app.

### ollama-hello-world-app _Python_

- **URL:** https://github.com/waggle-sensor/ollama-hello-world-app
- **Summary:** Hello world example to test Ollama inference and publish pipeline.

### plugin-file-uploader _Python_

- **URL:** https://github.com/waggle-sensor/plugin-file-uploader
- **Summary:** Edge App Template

### plugin-generic-template _Python_

- **URL:** https://github.com/waggle-sensor/plugin-generic-template
- **Summary:** plugin-generic-template

### plugin-hello-world _Dockerfile_

- **URL:** https://github.com/waggle-sensor/plugin-hello-world
- **Summary:** Tutorial Example: Publish Hello World

### plugin-helloworld-ml _Python_

- **URL:** https://github.com/waggle-sensor/plugin-helloworld-ml
- **Summary:** A template for applications running on Waggle nodes
- **Topics:** plugin, machine-learning

### Simple_Flower_Example _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/Simple_Flower_Example
- **Summary:** Simple Flower Example

## Plugins & apps — vision, ML, PTZ, image search (42)

### ai-tools _Python_

- **URL:** https://github.com/waggle-sensor/ai-tools
- **Summary:** Collection of tools for exploring AI/ML problems.

### anomaly-detection _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/anomaly-detection
- **Summary:** Some Jupyter Notebooks with encoding models for image anomaly detection

### app-image-viewer _Python_

- **URL:** https://github.com/waggle-sensor/app-image-viewer
- **Summary:** Simple example of using data and storage API to explore Sage data.

### Cloud-Optical-Flow _Python_

- **URL:** https://github.com/waggle-sensor/Cloud-Optical-Flow
- **Summary:** Using sky Imager Movies and Optical Flow to determine cloud speed.

### computer_vision _HTML_

- **URL:** https://github.com/waggle-sensor/computer_vision
- **Summary:** computer_vision

### HFSandbox _Python_

- **URL:** https://github.com/waggle-sensor/HFSandbox
- **Summary:** Repository for testing HF models on nodes

### imsearch_benchmaker _Python_

- **URL:** https://github.com/waggle-sensor/imsearch_benchmaker
- **Summary:** Image Search Benchmark Maker is a tool for creating image retrieval benchmarks.

### imsearch_benchmarks _Python_

- **URL:** https://github.com/waggle-sensor/imsearch_benchmarks
- **Summary:** A repository holding benchmarks created to be used on Sage Image Search

### imsearch_eval _Python_

- **URL:** https://github.com/waggle-sensor/imsearch_eval
- **Summary:** Abstract, extensible framework for benchmarking vector databases and models across different datasets for Sage Image Search.

### labelbox-tools _Python_

- **URL:** https://github.com/waggle-sensor/labelbox-tools
- **Summary:** This repo contains tools for managing projects and datasets on Labelbox.

### machinelearning _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/machinelearning
- **Summary:** machinelearning

### ml-neon-snow _Python_

- **URL:** https://github.com/waggle-sensor/ml-neon-snow
- **Summary:** Tools related to NEON snow image data.

### plugin-anomaly-detector _Python_

- **URL:** https://github.com/waggle-sensor/plugin-anomaly-detector
- **Summary:** General Purpose Image Anomaly Detector

### plugin-cloud-cover _Python_

- **URL:** https://github.com/waggle-sensor/plugin-cloud-cover
- **Summary:** Clouds have been widely studied in a variety of fields. The shape and distribution of clouds are not only important in modeling climate and weather, but also toward understanding the interactions between aerosols and clouds in weather research, and also to develop environment…

### plugin-cloudcover _Python_

- **URL:** https://github.com/waggle-sensor/plugin-cloudcover
- **Summary:** A cloud coverage estimator using machine learning models

### plugin-irradiance _Python_

- **URL:** https://github.com/waggle-sensor/plugin-irradiance
- **Summary:** plugin-FCN-cloud

### plugin-motion-analysis _Python_

- **URL:** https://github.com/waggle-sensor/plugin-motion-analysis
- **Summary:** Water Segmentation Plugin

### plugin-motion-detector _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/plugin-motion-detector
- **Summary:** Simple motion detector plugin.

### plugin-object-counter-yolov7 _Python_

- **URL:** https://github.com/waggle-sensor/plugin-object-counter-yolov7
- **Summary:** plugin-object-counter-yolov7

### plugin-objectcounter _Python_

- **URL:** https://github.com/waggle-sensor/plugin-objectcounter
- **Summary:** Car and pedestrian counter plugin

### plugin-pole-detector _Python_

- **URL:** https://github.com/waggle-sensor/plugin-pole-detector
- **Summary:** NEON Pole / Snow Rod Detection

### plugin-solar-controller _Python_

- **URL:** https://github.com/waggle-sensor/plugin-solar-controller
- **Summary:** Plugin for obtaining metrics from a solar charge controller

### plugin-solar-irradiance _Python_

- **URL:** https://github.com/waggle-sensor/plugin-solar-irradiance
- **Summary:** Background

### plugin-solarcloud _Python_

- **URL:** https://github.com/waggle-sensor/plugin-solarcloud
- **Summary:** Cloud Coverage Estimator

### plugin-surface-water-detection _Python_

- **URL:** https://github.com/waggle-sensor/plugin-surface-water-detection
- **Summary:** Author: Kazuto Nakashima,

### plugin-surfacewater _Python_

- **URL:** https://github.com/waggle-sensor/plugin-surfacewater
- **Summary:** plugin-surfacewater

### plugin-trafficcounter _Python_

- **URL:** https://github.com/waggle-sensor/plugin-trafficcounter
- **Summary:** Traffic Counter

### plugin-trafficstate _Python_

- **URL:** https://github.com/waggle-sensor/plugin-trafficstate
- **Summary:** Traffic state estimator

### plugin-vehicle-type-identifier _Python_

- **URL:** https://github.com/waggle-sensor/plugin-vehicle-type-identifier
- **Summary:** plugin-vehicle-detecter

### plugin-water-depth _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/plugin-water-depth
- **Summary:** Water Depth

### plugin-water-morph _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/plugin-water-morph
- **Summary:** plugin-water-level

### plugin-wildfire-smoke-detection _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/plugin-wildfire-smoke-detection
- **Summary:** sage-smoke-detection

### ptz-app _Python_

- **URL:** https://github.com/waggle-sensor/ptz-app
- **Summary:** This is an application for sending images of specific objects autonomously using PTZ cameras.

### ptz-sampler _Python_

- **URL:** https://github.com/waggle-sensor/ptz-sampler
- **Summary:** This is a plugin for sampling images from a ptz camera

### ptzjepa _Python_

- **URL:** https://github.com/waggle-sensor/ptzjepa
- **Summary:** Pan Tilt Zoom Joint Embedding Predictive Architecture (PTZJEPA)

### sage-nrp-image-search _fork, Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/sage-nrp-image-search
- **Summary:** Sage Image Search on NRP

### sage-smoke-detection _fork, Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/sage-smoke-detection
- **Summary:** sage-smoke-detection

### sage-vectordb-example _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/sage-vectordb-example
- **Summary:** Examples using Sage w/Weaviate

### solar-irradiance-estimation _Python_

- **URL:** https://github.com/waggle-sensor/solar-irradiance-estimation
- **Summary:** Training

### traffic-state _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/traffic-state
- **Summary:** - Functions for YOLOv4 are in the foler `tool`.  

### visual_disorder_plugin _Python_

- **URL:** https://github.com/waggle-sensor/visual_disorder_plugin
- **Summary:** Visual disorder app. Originally written by @Samaah330 and archived in waggle-sensor repo.

### VL_Correctness

- **URL:** https://github.com/waggle-sensor/VL_Correctness
- **Summary:** VL_Correctness

## Plugins & apps — audio, weather, sensors, triggers (42)

### app_birdcall_detector

- **URL:** https://github.com/waggle-sensor/app_birdcall_detector
- **Summary:** BirdCalls

### application-profiling _Python_

- **URL:** https://github.com/waggle-sensor/application-profiling
- **Summary:** Waggle Application Profiler (WaAP)

### goes-data _Python_

- **URL:** https://github.com/waggle-sensor/goes-data
- **Summary:** Plugin for GOES 16

### KonzaBurn _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/KonzaBurn
- **Summary:** Some jupyter notebooks for showing classification of wildfire using Llava on our Konza controlled burn images

### mobotix-setup _Shell_

- **URL:** https://github.com/waggle-sensor/mobotix-setup
- **Summary:** This repository has codes and config to setup the Mobotix M16 Thermal Camera.

### NEXRAD-reflectivity _Python_

- **URL:** https://github.com/waggle-sensor/NEXRAD-reflectivity
- **Summary:** This is a simple plugin that downloads NEXRAD files from Amazon S3 and extracts vertical profiles of base reflectivity above a selected latitude and longitude.

### phenocam_download_script _fork, Python_

- **URL:** https://github.com/waggle-sensor/phenocam_download_script
- **Summary:** Script to download PhenoCam images

### plugin-air-quality _Python_

- **URL:** https://github.com/waggle-sensor/plugin-air-quality
- **Summary:** Public repository `plugin-air-quality` (no GitHub description or README summary found).

### plugin-aqt _fork, Python_

- **URL:** https://github.com/waggle-sensor/plugin-aqt
- **Summary:** Waggle Sensor Plug-In for the Vaisala AQT530 Series Air Quality Transmitter

### plugin-audio-sampler _Python_

- **URL:** https://github.com/waggle-sensor/plugin-audio-sampler
- **Summary:** Simple plugin which creates and uploads short audio clips.

### plugin-base-images _Dockerfile_

- **URL:** https://github.com/waggle-sensor/plugin-base-images
- **Summary:** Dockerfiles and build processes for plugin base images

### plugin-bird-song-classifier _Python_

- **URL:** https://github.com/waggle-sensor/plugin-bird-song-classifier
- **Summary:** Bird song Classifier

### plugin-cl61-plot _Python_

- **URL:** https://github.com/waggle-sensor/plugin-cl61-plot
- **Summary:** Uploads files from a waggle node home folder to beehive.

### plugin-cmv-fftpc _Python_

- **URL:** https://github.com/waggle-sensor/plugin-cmv-fftpc
- **Summary:** The plugin uses the phase correlation/Optical flow method to compute cloud motion vectors from the Waggle sky camera images.

### plugin-controller _Go_

- **URL:** https://github.com/waggle-sensor/plugin-controller
- **Summary:** Plugin Controller

### plugin-hut-monitoring _C++_

- **URL:** https://github.com/waggle-sensor/plugin-hut-monitoring
- **Summary:** Hut monitoring plugin

### plugin-iio _Python_

- **URL:** https://github.com/waggle-sensor/plugin-iio
- **Summary:** Plugin which scans and publishes all detected Linux IIO parameters.
- **Topics:** node

### plugin-image-captioning _Python_

- **URL:** https://github.com/waggle-sensor/plugin-image-captioning
- **Summary:** A Waggle plugin captioning images using large language models

### plugin-imagesampler _Python_

- **URL:** https://github.com/waggle-sensor/plugin-imagesampler
- **Summary:** A simple plugin that samples images from a stream

### plugin-licor-7500ds _Python_

- **URL:** https://github.com/waggle-sensor/plugin-licor-7500ds
- **Summary:** uploads data as csv files

### plugin-licor-smartflux _Python_

- **URL:** https://github.com/waggle-sensor/plugin-licor-smartflux
- **Summary:** Data retrieval from Licor SmartFlux enabling real-time environmental data processing @Edge.

### plugin-metek-sonic3d-sampler _Python_

- **URL:** https://github.com/waggle-sensor/plugin-metek-sonic3d-sampler
- **Summary:** Plugin for METEK Sonic3D

### plugin-metek-sonic3d-tcp _Python_

- **URL:** https://github.com/waggle-sensor/plugin-metek-sonic3d-tcp
- **Summary:** Sampling Metek Data on TCP connection

### plugin-metsense _Python_

- **URL:** https://github.com/waggle-sensor/plugin-metsense
- **Summary:** Plugin which uses BME680 sensor to provide basic meteorological data.

### plugin-mobotix-move _Python_

- **URL:** https://github.com/waggle-sensor/plugin-mobotix-move
- **Summary:** Move a Mobotix camera to a specified preset location.

### plugin-mobotix-sampler _C++_

- **URL:** https://github.com/waggle-sensor/plugin-mobotix-sampler
- **Summary:** Plugin to sample the image and thermal data from the Mobotix camera

### plugin-mobotix-scan _C++_

- **URL:** https://github.com/waggle-sensor/plugin-mobotix-scan
- **Summary:** Testing object oriented code for thermal camera scanning

### plugin-radar-optical-flow _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/plugin-radar-optical-flow
- **Summary:** The code in `radar_data_processing.ipynb` allows users to:

### plugin-raingauge _Python_

- **URL:** https://github.com/waggle-sensor/plugin-raingauge
- **Summary:** Plugin which reads rain gauge values
- **Topics:** raspberry-pi, node

### plugin-rideshare _fork, Python_

- **URL:** https://github.com/waggle-sensor/plugin-rideshare
- **Summary:** Sage rideshare detection plugin for AI at the Edge

### plugin-sdr-sampler _fork, Python_

- **URL:** https://github.com/waggle-sensor/plugin-sdr-sampler
- **Summary:** SDR sampler to detect RF anomalies.

### plugin-sonic3d-rmyong _Python_

- **URL:** https://github.com/waggle-sensor/plugin-sonic3d-rmyong
- **Summary:** RMYong Sonic 3D Anemometer Sampler

### plugin-test-pipeline _Python_

- **URL:** https://github.com/waggle-sensor/plugin-test-pipeline
- **Summary:** Plugin to help smoke test our data pipeline.

### plugin-test-subscribe _Python_

- **URL:** https://github.com/waggle-sensor/plugin-test-subscribe
- **Summary:** Internal plugin to help perform system testing of Waggle Edge Stack.

### plugin-videosampler _Python_

- **URL:** https://github.com/waggle-sensor/plugin-videosampler
- **Summary:** Video Sampler Plugin

### plugin-wxt536 _fork, Python_

- **URL:** https://github.com/waggle-sensor/plugin-wxt536
- **Summary:** Waggle Sensor Plug-In for the Vaisala WXT536 Series weather transmitter

### plugin-yamnet _fork, Python_

- **URL:** https://github.com/waggle-sensor/plugin-yamnet
- **Summary:** SAGE plugin for YAMNet audio classification model

### sensors _HTML_

- **URL:** https://github.com/waggle-sensor/sensors
- **Summary:** Sensors integrated into Waggle

### severe-weather-trigger-example _Python_

- **URL:** https://github.com/waggle-sensor/severe-weather-trigger-example
- **Summary:** Example of using National Weather Service API to trigger starting / stopping a job.

### sonic-3d-sampler _Python_

- **URL:** https://github.com/waggle-sensor/sonic-3d-sampler
- **Summary:** Public repository `sonic-3d-sampler` (no GitHub description or README summary found).

### waggle-sonic3d _fork, Python_

- **URL:** https://github.com/waggle-sensor/waggle-sonic3d
- **Summary:** Waggle Sensor Plug-In for the METEK Sonic 3D anemometer

### wildfire-trigger-example _Python_

- **URL:** https://github.com/waggle-sensor/wildfire-trigger-example
- **Summary:** Wildfire Detection Workflow Example

## LoRaWAN (5)

### chirpstack_api_wrapper _Python_

- **URL:** https://github.com/waggle-sensor/chirpstack_api_wrapper
- **Summary:** An abstraction layer over the chirpstack_api python library
- **Topics:** lorawan, chirpstack

### init-chirpstack-server _Python_

- **URL:** https://github.com/waggle-sensor/init-chirpstack-server
- **Summary:** docker image for init chirpstack server job
- **Topics:** lorawan, chirpstack

### Lorawan-Packet-Test _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/Lorawan-Packet-Test
- **Summary:** This repo holds the assets we used to conduct a Lorawan Packet test on our rpi.lorawan compute

### Lorawan-test-device _C++_

- **URL:** https://github.com/waggle-sensor/Lorawan-test-device
- **Summary:** A device used to test Lorawan on WSN or rpi_lorawan WSN modules
- **Topics:** lorawan

### waggle-lorawan _Python_

- **URL:** https://github.com/waggle-sensor/waggle-lorawan
- **Summary:** Waggle LoRaWAN Usage Instructions

## Docs, websites, camps & notebooks (15)

### BCN-demos _Python_

- **URL:** https://github.com/waggle-sensor/BCN-demos
- **Summary:** Demo instructions

### community

- **URL:** https://github.com/waggle-sensor/community
- **Summary:** Repo dedicated to Waggle community discussions!

### documents

- **URL:** https://github.com/waggle-sensor/documents
- **Summary:** Papers, presentation material (PPT slides, PDF decks) and posters go here.

### jupyter-training-example _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/jupyter-training-example
- **Summary:** Model Training Example on Jupyter

### publications _TeX_

- **URL:** https://github.com/waggle-sensor/publications
- **Summary:** Papers, posters and publications by the team go here.
- **Topics:** papers, posters, presentation-slides

### sage-science-notebooks _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/sage-science-notebooks
- **Summary:** Collections of notebooks and tutorials using sage_data_client and beehive

### sage-website _HTML_

- **URL:** https://github.com/waggle-sensor/sage-website
- **Summary:** sagecontinuum.org (docs & tutorials)

### spring2025 _Python_

- **URL:** https://github.com/waggle-sensor/spring2025
- **Summary:** spring2025

### summer-camp-2026 _Python_

- **URL:** https://github.com/waggle-sensor/summer-camp-2026
- **Summary:** Workspace for Summer of AI 2026

### summer2022 _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/summer2022
- **Summary:** Summer 2022 Interns Repo

### summer2023 _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/summer2023
- **Summary:** Summer 2023 Student Repo

### summer2024 _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/summer2024
- **Summary:** Getting Started

### summer2025 _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/summer2025
- **Summary:** Summer Student Repository

### waggle-docs _HTML_

- **URL:** https://github.com/waggle-sensor/waggle-docs
- **Summary:** Waggle Documentation/Tutorial Website
- **Topics:** docs

### waggle-sensor.github.io

- **URL:** https://github.com/waggle-sensor/waggle-sensor.github.io
- **Summary:** Webpage

## Auth, VPN, storage, registry & ops tooling (19)

### ansible-pull-test

- **URL:** https://github.com/waggle-sensor/ansible-pull-test
- **Summary:** Public repository `ansible-pull-test` (no GitHub description or README summary found).

### django-address _fork, Python_

- **URL:** https://github.com/waggle-sensor/django-address
- **Summary:** A Django address model and field. Addresses may be specified by address components or by performing an automatic Google Maps lookup.

### hpwren-mirror _Python_

- **URL:** https://github.com/waggle-sensor/hpwren-mirror
- **Summary:** hpwren-mirror

### node-influxdb-loader _Python_

- **URL:** https://github.com/waggle-sensor/node-influxdb-loader
- **Summary:** Public repository `node-influxdb-loader` (no GitHub description or README summary found).
- **Topics:** waggle-edge-stack

### padm-pdu _Python_

- **URL:** https://github.com/waggle-sensor/padm-pdu
- **Summary:** Power Distribution Unit (PDU) Controller

### pandawn _Python_

- **URL:** https://github.com/waggle-sensor/pandawn
- **Summary:** Codes associated specifically with the PANDA-DAWN datasets

### portal-notice

- **URL:** https://github.com/waggle-sensor/portal-notice
- **Summary:** Adds banner to Sage portal

### sage-storage-loader _Go_

- **URL:** https://github.com/waggle-sensor/sage-storage-loader
- **Summary:** Load files from filesystem into SAGE object store

### sage-vpn-user-tools _Shell_

- **URL:** https://github.com/waggle-sensor/sage-vpn-user-tools
- **Summary:** User facing tools for Sage VPN.

### sheets2json _Go_

- **URL:** https://github.com/waggle-sensor/sheets2json
- **Summary:** JSON API to serve google sheets table

### unifi_switch_client _Python_

- **URL:** https://github.com/waggle-sensor/unifi_switch_client
- **Summary:** Python Client for Unifi EdgeSwitch 8 150W

### update-rabbitmq-users-from-beekeeper _Python_

- **URL:** https://github.com/waggle-sensor/update-rabbitmq-users-from-beekeeper
- **Summary:** Job to update RabbitMQ users from a Beekeeper.
- **Topics:** beehive, beekeeper

### update-upload-server-users-from-beekeeper _Python_

- **URL:** https://github.com/waggle-sensor/update-upload-server-users-from-beekeeper
- **Summary:** Job to update an upload server's users from a Beekeeper.
- **Topics:** beehive, beekeeper

### waggle-auth-app _Python_

- **URL:** https://github.com/waggle-sensor/waggle-auth-app
- **Summary:** Prototype space of Waggle auth app. Intend to merge work with sage-auth.

### waggle-network-watchdog _Python_

- **URL:** https://github.com/waggle-sensor/waggle-network-watchdog
- **Summary:** Waggle Network Watchdog
- **Topics:** node, deb, wildnode

### waggle-pki-tools _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-pki-tools
- **Summary:** Toolchain for building TLS and SSH PKIs.

### waggle-sanity-check _Shell_

- **URL:** https://github.com/waggle-sensor/waggle-sanity-check
- **Summary:** Waggle Sanity Check
- **Topics:** node, deb, wildnode

### zabbix-configs _Shell_

- **URL:** https://github.com/waggle-sensor/zabbix-configs
- **Summary:** Public repository `zabbix-configs` (no GitHub description or README summary found).

### zabbix-server-pgsql _Dockerfile_

- **URL:** https://github.com/waggle-sensor/zabbix-server-pgsql
- **Summary:** Customized Zabbix server image which provides additional tools.

## Org meta & shared GitHub config (1)

### .github

- **URL:** https://github.com/waggle-sensor/.github
- **Summary:** Repo for shared workflows and Github actions

## Other repositories (1)

### HPWREN_Experiments _Jupyter Notebook_

- **URL:** https://github.com/waggle-sensor/HPWREN_Experiments
- **Summary:** Some jupyter notebooks for showing classification of wildfire using Llava on HPWREN images

